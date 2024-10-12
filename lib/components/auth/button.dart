import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.consta,
      required this.onTap,
      required this.hint});
  final String hint;
  final VoidCallback onTap;
  final BoxConstraints consta;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: ButtonStyle(
            overlayColor:
                WidgetStatePropertyAll(AppColors.fillColor.withAlpha(75)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            fixedSize: WidgetStatePropertyAll(
                Size(consta.maxWidth * 0.7, consta.maxHeight * 0.09)),
            backgroundColor: const WidgetStatePropertyAll(AppColors.primary)),
        child: Text(
          hint,
          style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ));
  }
}
