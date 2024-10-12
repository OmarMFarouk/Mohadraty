import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({super.key, required this.isCurrent});
  final bool isCurrent;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Durations.long1,
      height: MediaQuery.sizeOf(context).height * 0.01,
      margin: const EdgeInsets.only(left: 5),
      width: isCurrent
          ? MediaQuery.sizeOf(context).height * 0.075
          : MediaQuery.sizeOf(context).height * 0.05,
      decoration: BoxDecoration(
          color:
              isCurrent ? AppColors.primary : AppColors.primary.withAlpha(80),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
