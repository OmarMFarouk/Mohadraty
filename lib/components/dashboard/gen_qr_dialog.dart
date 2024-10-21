import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mohadraty/components/auth/button.dart';
import 'package:mohadraty/src/app_navigator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrGeneratorDialog extends StatelessWidget {
  const QrGeneratorDialog(
      {super.key, required this.controller, required this.qrCode});
  final String qrCode;
  final ScreenshotController controller;
  static show(context, qrCode, controller) => showDialog(
      context: context,
      builder: (context) => QrGeneratorDialog(
            controller: controller,
            qrCode: qrCode,
          ).build(context));
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFBEFF6C), width: 5)),
        height: MediaQuery.sizeOf(context).height * 0.4,
        width: MediaQuery.sizeOf(context).width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: controller,
              child: QrImageView(
                data: qrCode,
                backgroundColor: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AuthButton(
                    consta: const BoxConstraints.expand(),
                    onTap: () => AppNavigator.pop(context),
                    hint: 'Okay'),
                AuthButton(
                    consta: const BoxConstraints.expand(),
                    onTap: () async {
                      await controller.capture().then((image) {
                        ImageGallerySaver.saveImage(image!);
                      });
                      Fluttertoast.showToast(msg: 'Saved');
                    },
                    hint: 'Save to device'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
