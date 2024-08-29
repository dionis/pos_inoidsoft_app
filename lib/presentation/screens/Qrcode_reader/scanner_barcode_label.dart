import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedBarcodeLabel extends ConsumerWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  final String SCAN_PRODUCT_LABEL = 'Scanee el QR del producto';
  // 'Scan something!';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return Text(
            SCAN_PRODUCT_LABEL,
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          );
        }

        // return Text(
        //   scannedBarcodes.first.displayValue ?? 'No display value.',
        //   overflow: TextOverflow.fade,
        //   style: const TextStyle(color: Colors.white),
        // );

        return const Text(
          '',
          overflow: TextOverflow.fade,
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}
