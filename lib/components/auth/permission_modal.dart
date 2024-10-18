import 'package:flutter/material.dart';
import 'package:mohadraty/services/location.dart';

import '../../services/notification.dart';
import '../../src/app_colors.dart';
import '../../src/app_shared.dart';
import '../../view/auth/index.dart';
import 'button.dart';
import '../../src/app_navigator.dart';

class PermissionModalSheet extends StatelessWidget {
  const PermissionModalSheet({super.key, required this.consta});
  final BoxConstraints consta;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: AppColors.fillColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Permissions Notifier',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Mohadraty will be granted your notifications, location and camera permissions, this is to improve your app experience, make it better and more efficient. All personal information will be handled in accordance with our Privacy Policy, Users have to agree to our Terms&Conditions in order to continue using the app, T&C and privacy policy can be found in the app.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey.withAlpha(200)),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: AuthButton(
                consta: consta,
                hint: 'Continue',
                onTap: () async {
                  await AppShared.localStorage.setBool('onboarded', true);
                  await Future.wait([
                    NotificationService.initFCM(),
                    LocationService().requestPermission(),
                  ]);
                  AppNavigator.pushR(context, const AuthIndex(),
                      NavigatorAnimation.slideAnimation);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
