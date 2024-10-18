import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../components/general/snackbar.dart';
import '../../services/api/auth_api.dart';
import '../../src/app_shared.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  final loginForm = GlobalKey<FormState>();
  final registerForm = GlobalKey<FormState>();
  bool isStudent = true;
  bool canPop = false;

  register() async {
    emit(AuthInitial());
    if (registerForm.currentState!.validate()) {
      EasyLoading.show(status: 'Loading...');
      await AuthApi()
          .register(
              type: isStudent ? 'student' : 'tutor',
              name: '${firstNameCont.text} ${lastNameCont.text}',
              email: emailCont.text.toLowerCase(),
              password: passwordCont.text)
          .then((res) {
        if (res == null || res == 'error') {
          EasyLoading.dismiss();
          emit(AuthFailure('Check Internet Connections'));
        }
        if (res['success'] == true) {
          emit(AuthSuccess(res['message']));

          clearNsave(res['user_type']);
          EasyLoading.dismiss();
        } else {
          EasyLoading.dismiss();
          emit(AuthFailure(res['message']));
        }
      });
    }
  }

  login() async {
    emit(AuthInitial());
    if (loginForm.currentState!.validate()) {
      EasyLoading.show(status: 'Loading...');
      await AuthApi()
          .login(
        email: emailCont.text.trim(),
        password: passwordCont.text.trim(),
      )
          .then((res) {
        if (res == null || res == 'error') {
          EasyLoading.dismiss();
          emit(AuthFailure('Check Internet Connections'));
        }
        if (res['success'] == true) {
          emit(AuthSuccess(res['message']));
          clearNsave(res['user_type']);
          EasyLoading.dismiss();
        } else {
          EasyLoading.dismiss();
          emit(AuthFailure(res['message']));
        }
      });
    }
  }

  onAppClose(didPop, context) {
    if (didPop) {
      return;
    }
    Future.delayed(const Duration(seconds: 3), () {
      refreshState();
      canPop = false;
    });
    canPop = true;
    MySnackbar.show(context: context, msg: 'Are You Sure?', isError: true);
    refreshState();
  }

  refreshState() {
    emit(AuthInitial());
  }

  clearNsave(userType) async {
    if (firstNameCont.text.isNotEmpty) {
      await AppShared.localStorage
          .setString('name', '${firstNameCont.text} ${lastNameCont.text}');
    }
    await AppShared.localStorage
        .setString('email', emailCont.text.toLowerCase());
    await AppShared.localStorage.setString('userType', userType);
    await AppShared.localStorage.setBool('active', true);
    firstNameCont.clear();
    lastNameCont.clear();
    passwordCont.clear();
    emailCont.clear();
  }
}
