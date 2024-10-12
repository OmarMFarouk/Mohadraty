import 'package:flutter/material.dart';
import 'package:mohadraty/components/auth/button.dart';
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
            const Text(
              'Welcome to Mohadraty',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                  color: Colors.white,
                  decorationColor: Colors.black,
                  letterSpacing: 1),
            ),
            const SizedBox(height: kToolbarHeight * 0.5),
            AuthButton(
                consta: consta,
                onTap: () => pageController.animateToPage(1,
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 350)),
                hint: 'Login'),
            const SizedBox(height: kToolbarHeight * 0.5),
            AuthButton(
                consta: consta,
                onTap: () => pageController.animateToPage(2,
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 350)),
                hint: 'Register'),
          ],
        ),
      );
    });
  }
}
