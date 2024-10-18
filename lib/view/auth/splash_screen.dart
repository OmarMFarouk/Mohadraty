import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/services/notification.dart';
import 'package:mohadraty/src/app_assets.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_navigator.dart';
import 'package:mohadraty/src/app_shared.dart';
import 'package:mohadraty/view/dashboard.dart';
import 'package:mohadraty/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    await NotificationService.initFCM();
    if (AppShared.localStorage.getString('userType') == 'student') {
      await BlocProvider.of<MainCubit>(context).fetchStudentData();
      Future.delayed(
          const Duration(seconds: 1),
          () => AppNavigator.pushR(
              context, const HomeScreen(), NavigatorAnimation.fadeAnimation));
    } else {
      await BlocProvider.of<MainCubit>(context).fetchTutorData();
      Future.delayed(
          const Duration(seconds: 1),
          () => AppNavigator.pushR(context, const DashboardScreen(),
              NavigatorAnimation.fadeAnimation));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                    color: AppColors.primary.withAlpha(50),
                    offset: const Offset(0, 70),
                    spreadRadius: 120,
                    blurRadius: 80)
              ]),
              child: const Text(
                'Mohadraty',
                style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldish,
                ),
              ),
            ),
            const SizedBox(
              height: kToolbarHeight,
            ),
            Image.asset(AppAssets.loadingGIF),
          ],
        ),
      ),
    );
  }
}
