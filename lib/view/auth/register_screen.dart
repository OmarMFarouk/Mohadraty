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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.controller});
  final PageController controller;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      key: cubit.registerForm,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: kToolbarHeight,
                            ),
                            const Text(
                              'Create Your\nAccount',
                              style: TextStyle(
                                  fontSize: 37,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: kToolbarHeight * 0.5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: AuthField(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return '*Field is required';
                                          } else if (RegExp("[0-9]")
                                              .hasMatch(p0)) {
                                            return '*Invalid name format';
                                          }
                                          return null;
                                        },
                                        controller: cubit.firstNameCont,
                                        hint: 'First Name')),
                                SizedBox(
                                  width: consta.maxWidth * 0.02,
                                ),
                                Expanded(
                                    child: AuthField(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return '*Field is required';
                                          } else if (!RegExp("[a-zA-Z]")
                                              .hasMatch(p0)) {
                                            return '*Invalid name format';
                                          }
                                          return null;
                                        },
                                        controller: cubit.lastNameCont,
                                        hint: 'Last Name')),
                              ],
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
                                    hint: 'Register',
                                    onTap: () => cubit.register())),
                            SizedBox(height: consta.maxHeight * 0.02),
                            AuthOptions(
                              onTap: () => widget.controller.animateToPage(1,
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: const Duration(milliseconds: 350)),
                              hint: 'Sign In',
                              title: 'Already Have An Account?',
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
