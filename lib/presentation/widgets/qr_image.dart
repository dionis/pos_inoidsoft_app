import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  QRImage(this.infoToShow, {super.key});

  final String infoToShow;

  String PRODUCT_QR_INFO = "QR del Producto";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PRODUCT_QR_INFO),
        centerTitle: true,
      ),
      body: Center(
        child: QrImageView(
          data: infoToShow,
          size: 280,
          // You can include embeddedImageStyle Property if you
          //wanna embed an image from your Asset folder
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: const Size(
              100,
              100,
            ),
          ),
        ),
      ),
    );
  }
}
