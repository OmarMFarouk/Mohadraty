import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/view/auth/index.dart';

import '../../components/auth/button.dart';
import '../../components/auth/indicators.dart';
import '../../components/auth/onboarding_template.dart';
import '../../components/auth/permission_modal.dart';
import '../../src/app_assets.dart';
import '../../src/app_navigator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> onboardingDetails = [
    OnboardingTemplate(
      image: AppAssets.timeIllu,
      subTitle: 'Have all your classes in one place, Goodbye time waste!',
      title: 'Save Time',
    ),
    OnboardingTemplate(
      image: AppAssets.attendanceIllu,
      subTitle: 'Easily check your attendance in your classes',
      title: 'Track Your Progress',
    ),
    OnboardingTemplate(
      image: AppAssets.freeIllu,
      subTitle:
          'Supporting students and tutors all around the globe with no limitations',
      title: 'Always Free',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: LayoutBuilder(builder: (context, consta) {
        return Column(
          crossAxisAlignment: currentIndex == 2
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.end,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
              child: currentIndex == 2
                  ? const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  : InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => pageController.animateToPage(
                          currentIndex + 1,
                          duration: Durations.long4,
                          curve: Curves.fastLinearToSlowEaseIn),
                      child: Ink(
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary.withAlpha(100),
                          radius: 30,
                          child: const Text(
                            '⪼',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 24),
                          ),
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  children: onboardingDetails),
            ),
            currentIndex == 2
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnboardingIndicator(isCurrent: currentIndex == 0),
                      OnboardingIndicator(isCurrent: currentIndex == 1),
                      OnboardingIndicator(isCurrent: currentIndex == 2),
                    ],
                  ),
            SizedBox(height: consta.maxHeight * 0.05),
            currentIndex == 2
                ? AuthButton(
                    hint: 'Get Started',
                    consta: consta,
                    onTap: () async {
                      if (currentIndex != 2) {
                        pageController.animateToPage(currentIndex + 1,
                            duration: Durations.long4,
                            curve: Curves.fastLinearToSlowEaseIn);
                      } else {
                        await showModalBottomSheet(
                            isDismissible: false,
                            isScrollControlled: true,
                            enableDrag: false,
                            context: context,
                            builder: (context) => PermissionModalSheet(
                                  consta: consta,
                                ));
                        // ignore: use_build_context_synchronously
                        AppNavigator.pushR(context, const AuthIndex(),
                            NavigatorAnimation.slideAnimation);
                      }
                    },
                  )
                : const SizedBox(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          ],
        );
      }),
    );
  }
}
