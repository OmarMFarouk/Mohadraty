import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohadraty/components/auth/button.dart';
import 'package:mohadraty/src/app_assets.dart';
import 'package:mohadraty/src/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, consta) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              scale: 7,
            ),
            Center(
              child: Text(
                context.tr('welcome'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    color: Colors.white,
                    decorationColor: Colors.black,
                    letterSpacing: 1),
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.5),
            AuthButton(
              consta: consta,
              onTap: () => pageController.animateToPage(1,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 350)),
              hint: context.tr('login'),
            ),
            const SizedBox(height: kToolbarHeight * 0.5),
            AuthButton(
              consta: consta,
              onTap: () => pageController.animateToPage(2,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 350)),
              hint: context.tr('signup'),
            ),
          ],
        ),
      );
    });
  }
}
