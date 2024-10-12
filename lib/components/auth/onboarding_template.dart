import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_colors.dart';

class OnboardingTemplate extends StatelessWidget {
  const OnboardingTemplate({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });
  final String title, subTitle, image;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Image.asset(image),
            SizedBox(height: constrain.maxHeight * 0.05),
            Text(
              title,
              style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            SizedBox(height: constrain.maxHeight * 0.01),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      );
    });
  }
}
