import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mohadraty/model/main_model.dart';
import 'package:mohadraty/services/api/main_api.dart';

import '../../components/general/snackbar.dart';
import 'main_states.dart';

MainModel? mainModel;

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  TextEditingController codeCont = TextEditingController();
  TextEditingController idCont = TextEditingController();
  bool canPop = false;

  Future<void> fetchMainData() async {
    emit(MainLoading());
    await MainApi().fetchMainData().then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        mainModel = MainModel.fromJson(res);
        currentDay = mainModel!.dow!;
        emit(MainSuccess());
      } else {
        emit(MainFailure(res['message']));
      }
    });
  }

  Future<void> joinClass() async {
    emit(MainLoading());
    EasyLoading.show(status: 'Loading...');
    await MainApi()
        .joinClass(courseCode: codeCont.text, studentId: idCont.text)
        .then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        emit(MainAdded(res['message']));

        codeCont.clear();
        idCont.clear();
      } else {
        emit(MainFailure(res['message']));
      }
      EasyLoading.dismiss();
    });
  }

  Future<void> attendClass({required String qrCode}) async {
    emit(MainLoading());
    EasyLoading.show(status: 'Loading...');
    await MainApi().attendClass(qrCode).then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        emit(MainAdded(res['message']));
      } else {
        emit(MainFailure(res['message']));
      }
      EasyLoading.dismiss();
    });
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
    emit(MainInitial());
  }
}

String currentDay = '';
