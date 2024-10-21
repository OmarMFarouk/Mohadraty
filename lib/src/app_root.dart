import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mohadraty/bloc/auth_bloc/auth_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/src/app_shared.dart';
import 'package:mohadraty/view/auth/index.dart';
import 'package:mohadraty/view/auth/splash_screen.dart';

import '../view/auth/onboarding_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()..initialize(context)),
        BlocProvider(create: (context) => AuthCubit())
      ],
      child: SafeArea(
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          theme: ThemeData(fontFamily: 'Cairo', primarySwatch: Colors.red),
          home: AppShared.localStorage.getBool('onboarded') == false
              ? const OnboardingScreen()
              : AppShared.localStorage.getBool('active') == true
                  ? const SplashScreen()
                  : const AuthIndex(),
        ),
      ),
    );
  }
}
