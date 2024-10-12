import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_assets.dart';

class StateDialog extends StatelessWidget {
  const StateDialog(
      {super.key, required this.msg, required this.isError, this.onTap});
  final String msg;
  final bool isError;
  final VoidCallback? onTap;
  static show(context, msg, isError) => showDialog(
      context: context,
      builder: (context) => StateDialog(
            msg: msg,
            isError: isError,
          ).build(context));
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFBEFF6C), width: 5)),
        height: MediaQuery.sizeOf(context).height * 0.35,
        width: MediaQuery.sizeOf(context).width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              !isError ? AppAssets.qrSuccessGIF : AppAssets.failGIF,
              repeat: ImageRepeat.noRepeat,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 50)),
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFC5ECB4))),
                onPressed: onTap ?? () => Navigator.pop(context),
                child: const Text('OKAY',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
