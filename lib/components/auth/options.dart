import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_colors.dart';

class AuthOptions extends StatelessWidget {
  const AuthOptions(
      {super.key,
      required this.title,
      required this.hint,
      required this.onTap});
  final String title, hint;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 17, color: AppColors.grey, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: onTap,
            child: Text(
              hint,
              style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ))
      ],
    );
  }
}
