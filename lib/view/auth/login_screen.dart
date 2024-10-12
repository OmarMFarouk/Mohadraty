import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/auth_bloc/auth_cubit.dart';
import 'package:mohadraty/bloc/auth_bloc/auth_states.dart';
import 'package:mohadraty/components/home_screen/states_dialog.dart';
import 'package:mohadraty/src/app_assets.dart';

import '../../components/auth/app_bar.dart';
import '../../components/auth/button.dart';
import '../../components/auth/formfield.dart';
import '../../components/auth/options.dart';
import '../../src/app_navigator.dart';
import 'splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final PageController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is AuthSuccess) {
        AppNavigator.pushR(
            context, const SplashScreen(), NavigatorAnimation.scaleAnimation);
      }
      if (state is AuthFailure) {
        StateDialog.show(context, state.msg, true);
      }
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return LayoutBuilder(builder: (context, consta) {
        return Stack(
          children: [
            Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: AuthAppBar(controller: widget.controller)),
              backgroundColor: const Color(0xFF141416),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: cubit.loginForm,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: kToolbarHeight,
                            ),
                            const Text(
                              'Login To Your\nAccount',
                              style: TextStyle(
                                  fontSize: 37,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: kToolbarHeight * 0.5,
                            ),
                            AuthField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return '*Field is required';
                                } else if (!RegExp(
                                            r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                                        .hasMatch(val) ||
                                    val.contains('@.') ||
                                    val.contains('.@')) {
                                  return '*Invalid email';
                                }
                                return null;
                              },
                              controller: cubit.emailCont,
                              hint: 'Email',
                            ),
                            AuthField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return '*Field is required';
                                } else if (val.length < 8) {
                                  return '*Password should be atleast 8 characters.';
                                }
                                return null;
                              },
                              controller: cubit.passwordCont,
                              hint: 'Password',
                              obscure: true,
                            ),
                            Center(
                                child: AuthButton(
                                    consta: consta,
                                    hint: 'Login',
                                    onTap: () => cubit.login())),
                            SizedBox(height: consta.maxHeight * 0.02),
                            AuthOptions(
                              onTap: () => widget.controller.animateToPage(2,
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: const Duration(milliseconds: 350)),
                              hint: 'Sign Up',
                              title: "Don't Have An Account?",
                            ),
                          ]),
                    ),
                  )),
            ),
            Positioned(
                right: consta.maxWidth * 0.075,
                child: Image.asset(
                  AppAssets.ideaIllu,
                  scale: 0.9,
                )),
          ],
        );
      });
    });
  }
}
