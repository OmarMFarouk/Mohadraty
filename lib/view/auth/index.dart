import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/auth_bloc/auth_cubit.dart';
import 'package:mohadraty/src/app_assets.dart';
import 'package:mohadraty/view/auth/login_screen.dart';
import 'package:mohadraty/view/auth/register_screen.dart';
import 'package:mohadraty/view/auth/welcome_screen.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  void initState() {
    AppAssets.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: BlocProvider.of<AuthCubit>(context).canPop,
      onPopInvoked: (didPop) {
        BlocProvider.of<AuthCubit>(context).onAppClose(didPop, context);
      },
      child: Scaffold(
        body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              WelcomeScreen(
                pageController: pageController,
              ),
              LoginScreen(controller: pageController),
              RegisterScreen(controller: pageController),
            ],
            onPageChanged: (value) => setState(() {})),
      ),
    );
  }
}
