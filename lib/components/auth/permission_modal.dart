import 'package:flutter/material.dart';
import 'package:mohadraty/services/location.dart';
import 'package:mohadraty/src/app_endpoints.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Row(
              children: [
                const Text('App Notice',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary)),
                const Spacer(),
                IconButton(
                    tooltip: 'Read Privacy Policy / T&C',
                    onPressed: () => launchUrl(Uri.parse(AppEndPoints.terms)),
                    icon: const Icon(
                      Icons.help_outline,
                      size: 30,
                      color: AppColors.primary,
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "By using Mohadraty, you agree to our Terms & Conditions. These terms outline your rights and responsibilities, and how we handle your information. Please read them carefully",
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
