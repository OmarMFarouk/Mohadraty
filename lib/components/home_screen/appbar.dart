import 'package:flutter/material.dart';
import 'package:mohadraty/view/settings_screen.dart';

import '../../src/app_colors.dart';
import '../../src/app_navigator.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          const Text(
            'Home',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => AppNavigator.push(context, const SettingScreen(),
                NavigatorAnimation.slideAnimation),
            icon: const Icon(
              Icons.settings,
              color: AppColors.grey,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
