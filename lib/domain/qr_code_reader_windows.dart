import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pos_inoidsoft_app/models/product.dart';
import 'package:string_validator/string_validator.dart';
import '../models/cart_item.dart';
import '../presentation/providers/config_state_variables.dart';
import 'scanner_barcode_label.dart';
import 'scanner_error_widget.dart';

final _formKey = GlobalKey<FormState>();
const String PRODUCT_NAME = "Nombre del producto";
const String ERROR_TEXT_PRODUCT_NAME = "El nombre del producto es obligatorio";
const String ADD_PRODUCT = "Añadir producto";
const String PRODUCT_PRICE = "Precio del Producto";

class QrReaderCodeWindow extends ConsumerStatefulWidget {
  const QrReaderCodeWindow({super.key});

  @override
  ConsumerState<QrReaderCodeWindow> createState() => _QrReaderCodeWindowState();
}

class _QrReaderCodeWindowState extends ConsumerState<QrReaderCodeWindow> {
  final MobileScannerController controller = MobileScannerController();

  String NOT_READ_QR_CODE = 'No se ha leido el código QR del producto';
  bool showBottomSheetForm = true;

  String NOT_REGISTERED_ITEM = 'El producto no esta registrado';
  String NOT_REGISTERED_ITEM_ADD =
      'El producto no esta registrado, debe insertar su información';

  String ALREADY_IN_SHOPPING_LIST = 'El producto ya esta en la lista de compra';
  //"The product is already on the shopping list ";

  Widget _buildBarcodeOverlay() {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        // Not ready.
        if (!value.isInitialized || !value.isRunning || value.error != null) {
          return const SizedBox();
        }

        return StreamBuilder<BarcodeCapture>(
          stream: controller.barcodes,
          builder: (context, snapshot) {
            final BarcodeCapture? barcodeCapture = snapshot.data;

            // No barcode.
            if (barcodeCapture == null || barcodeCapture.barcodes.isEmpty) {
              return const SizedBox();
            }

            final scannedBarcode = barcodeCapture.barcodes.first;

            // No barcode corners, or size, or no camera preview size.
            if (scannedBarcode.corners.isEmpty ||
                value.size.isEmpty ||
                barcodeCapture.size.isEmpty) {
              return const SizedBox();
            }

            return CustomPaint(
              painter: BarcodeOverlay(
                barcodeCorners: scannedBarcode.corners,
                barcodeSize: barcodeCapture.size,
                boxFit: BoxFit.contain,
                cameraPreviewSize: value.size,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildScanWindow(Rect scanWindowRect) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        // Not ready.
        if (!value.isInitialized ||
            !value.isRunning ||
            value.error != null ||
            value.size.isEmpty) {
          return const SizedBox();
        }

        return CustomPaint(
          painter: ScannerOverlay(scanWindowRect),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Scaffold(
      //appBar: AppBar(title: const Text('With Scan window')),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            fit: BoxFit.contain,
            scanWindow: scanWindow,
            controller: controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            onDetect: (BarcodeCapture capture) async {
              final List<Barcode> barcodes = capture.barcodes;
              final Barcode barcode = barcodes.first;
              final String data = barcode.rawValue ?? NOT_READ_QR_CODE;

              if (NOT_READ_QR_CODE != data && showBottomSheetForm == true) {
                showBottomSheetForm = !showBottomSheetForm;

                //Parse JSON from QR read
                //
                //
                try {
                  final productJson = jsonDecode(data);
                  final Product qrReadProduct = Product.fromJson(productJson);

                  Fluttertoast.showToast(
                      msg: "IS VALID QR ITEM: ${data}",
                      toastLength: Toast.LENGTH_SHORT);

                  //Find if exist in Data Base current Product
                  // - It was updated recientelly use the dada base information
                  final Product existProduct = products.firstWhere(
                      (element) => element.title == qrReadProduct.title,
                      orElse: () => Product(title: '', price: 0, rate: 0));

                  if (existProduct.title.isEmpty) {
                    Fluttertoast.showToast(
                        msg: NOT_REGISTERED_ITEM,
                        toastLength: Toast.LENGTH_SHORT);
                  }

                  findItemInShoppingList(qrReadProduct, data);

                  // - Go to POS Cashier page
                } on FormatException catch (e) {
                  //Validate if only numbers about barcode
                  validateIfAlphanumericBarCode(data);
                } catch (e) {
                  validateIfAlphanumericBarCode(data);
                }
              }

              Future.delayed(const Duration(seconds: 10), () {
                showBottomSheetForm = true;
              });
            },
          ),
          _buildBarcodeOverlay(),
          _buildScanWindow(scanWindow),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.topCenter,
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                // height: 100,
                color: Colors.black.withOpacity(0.4),
                child: ScannedBarcodeLabel(barcodes: controller.barcodes),
              )),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }

  void validateIfAlphanumericBarCode(String data) {
    if (data.isAlphanumeric) {
      Fluttertoast.showToast(
          msg: "IS ALPHANUMERIC: ${data}", toastLength: Toast.LENGTH_SHORT);

      // - It was updated recientelly use the dada base information
      // - Update information set quantity in on
      final Product existProduct = products.firstWhere(
          (element) => element.barcode == data,
          orElse: () => Product(title: '', price: 0, rate: 0));

      if (existProduct.title.isEmpty) {
        Fluttertoast.showToast(
            msg: NOT_REGISTERED_ITEM_ADD, toastLength: Toast.LENGTH_SHORT);
      } else {
        findItemInShoppingList(existProduct, data);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Not alphanumeric: ${data} please SCAN a corret QR or Barcode",
          toastLength: Toast.LENGTH_SHORT);
      //Stay in page since user go to another option
    }
  }

  void findItemInShoppingList(Product existProduct, String data) {
    // - Add in Current Buy list as firtst element
    if (cartItems.isEmpty) {
      cartItems.add(CartItem(quantity: 1, product: existProduct));
    } else {
      CartItem existItemInCart;

      try {
        existItemInCart = cartItems.firstWhere(
            (element) => element?.product?.title == existProduct.title,
            orElse: () => CartItem(quantity: 1, product: null));

        if (existProduct == null) {
          existItemInCart = cartItems.firstWhere(
              (element) => element.product?.barcode == data,
              orElse: () => CartItem(quantity: 1, product: null));
        }
      } catch (e) {
        existItemInCart = CartItem(quantity: 1, product: null);
      }

      if (existItemInCart.product != null) {
        Fluttertoast.showToast(
            msg: ALREADY_IN_SHOPPING_LIST, toastLength: Toast.LENGTH_SHORT);
      } else {
        // - Add in Current Buy list as firtst element
        cartItems.add(CartItem(quantity: 1, product: existProduct));

        // - Go to POS Cashier page
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("MainPoSScreen", 2);
      }
    }
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: use `Offset.zero & size` instead of Rect.largest
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    required this.barcodeCorners,
    required this.barcodeSize,
    required this.boxFit,
    required this.cameraPreviewSize,
  });

  final List<Offset> barcodeCorners;
  final Size barcodeSize;
  final BoxFit boxFit;
  final Size cameraPreviewSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcodeCorners.isEmpty ||
        barcodeSize.isEmpty ||
        cameraPreviewSize.isEmpty) {
      return;
    }

    final adjustedSize = applyBoxFit(boxFit, cameraPreviewSize, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final double ratioWidth;
    final double ratioHeight;

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      ratioWidth = barcodeSize.width / adjustedSize.destination.width;
      ratioHeight = barcodeSize.height / adjustedSize.destination.height;
    } else {
      ratioWidth = cameraPreviewSize.width / adjustedSize.destination.width;
      ratioHeight = cameraPreviewSize.height / adjustedSize.destination.height;
    }

    final List<Offset> adjustedOffset = [
      for (final offset in barcodeCorners)
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
    ];

    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
