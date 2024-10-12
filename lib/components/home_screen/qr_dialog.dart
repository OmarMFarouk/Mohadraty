import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'qr_animation.dart';

class QrDialog extends StatelessWidget {
  const QrDialog(
      {super.key, required this.controller, required this.onCapture});
  final Function(BarcodeCapture) onCapture;
  final MobileScannerController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FractionallySizedBox(
          heightFactor: 0.35,
          widthFactor: 0.7,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 7, color: const Color(0xFFBEFF6C))),
            child: MobileScanner(
              controller: controller,
              onDetect: onCapture,
            ),
          ),
        ),
        const QrAnimation()
      ],
    );
  }
}
