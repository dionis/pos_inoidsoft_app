import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pos_inoidsoft_app/models/product.dart';
import 'package:string_validator/string_validator.dart';
import 'scanner_barcode_label.dart';
import 'scanner_error_widget.dart';

final _formKey = GlobalKey<FormState>();
const String PRODUCT_NAME = "Nombre del producto";
const String ERROR_TEXT_PRODUCT_NAME = "El nombre del producto es obligatorio";
const String ADD_PRODUCT = "Añadir producto";
const String PRODUCT_PRICE = "Precio del Producto";

class QrReaderCodeWindow extends StatefulWidget {
  const QrReaderCodeWindow({super.key});

  @override
  State<QrReaderCodeWindow> createState() => _QrReaderCodeWindowState();
}

class _QrReaderCodeWindowState extends State<QrReaderCodeWindow> {
  final MobileScannerController controller = MobileScannerController();

  String NOT_READ_QR_CODE = 'No se ha leido el código QR del producto';
  bool showBottomSheetForm = true;

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

                  //Find if exist in Data Base current Product
                  // - It was updated recientelly use the dada base information
                  // - Update information set quantity in on
                  // - Add in Current Buy list as firtst element
                  // - Go to POS Cashier page
                  Fluttertoast.showToast(
                      msg: "IS ALPHANUMERIC: ${qrReadProduct.title}",
                      toastLength: Toast.LENGTH_SHORT);
                } on FormatException catch (e) {
                  //Validate if only numbers about barcode
                  validateIfAlphanumericBarCode(data);
                } catch (e) {
                  validateIfAlphanumericBarCode(data);
                }
              } else {
                Future.delayed(const Duration(seconds: 10), () {
                  showBottomSheetForm = true;
                });
              }
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
      // - Add in Current Buy list as firtst element
      // - Go to POS Cashier page
    } else {
      Fluttertoast.showToast(
          msg: "Not alphanumeric: ${data} please SCAN a corret QR or Barcode",
          toastLength: Toast.LENGTH_SHORT);
      //Stay in page since user go to another option
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
