import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mohadraty/components/dashboard/day_picker.dart';
import 'package:mohadraty/components/dashboard/duration_picker.dart';
import 'package:mohadraty/model/student_model.dart';
import 'package:mohadraty/model/tutor_model.dart';
import 'package:mohadraty/services/api/main_api.dart';

import '../../components/general/snackbar.dart';
import '../../services/location.dart';
import '../../src/app_shared.dart';
import 'main_states.dart';

StudentModel? studentModel;
TutorModel? tutorModel;

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  TextEditingController codeCont = TextEditingController();
  TextEditingController idCont = TextEditingController();
  bool canPop = false;
  XFile? pickedImage;
  String startDate = '';
  TutorCourse? selectedCourse;
  String endDate = '';
  List<TutorEnrolment> pending = [];
  Future<void> fetchStudentData() async {
    emit(MainLoading());
    await MainApi().fetchStudentData().then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        studentModel = StudentModel.fromJson(res);
        currentDay = studentModel!.dow!;
        emit(MainSuccess());
      } else {
        emit(MainFailure(res['message']));
      }
    });
  }

  Future<void> fetchTutorData() async {
    pending.clear();
    emit(MainLoading());
    await MainApi().fetchTutorData().then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        tutorModel = TutorModel.fromJson(res);
        currentDay = tutorModel!.dow!;

        for (var enrolment in tutorModel!.enabledCourses!) {
          for (var request in enrolment!.enrolments!) {
            if (request!.enrolmentstatus == 'pending') {
              pending.add(request);
            }
          }
        }
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

  Future<void> createClass() async {
    emit(MainLoading());
    EasyLoading.show(status: 'Loading...');
    await MainApi()
        .createClass(
            courseCode: codeCont.text,
            classTitle: idCont.text.trim(),
            endDate: endDate,
            startDate: startDate,
            weekDays: selectedDays
                .toString()
                .replaceAll(']', '')
                .replaceAll('[', '')
                .replaceAll(' ', ''),
            weekHours: selectedHours
                .toString()
                .replaceAll(']', '')
                .replaceAll('[', '')
                .replaceAll(' ', ''),
            path: pickedImage!.path)
        .then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        emit(MainAdded(res['message']));
        clearCont();
        fetchTutorData();
      } else {
        emit(MainFailure(res['message']));
      }
      EasyLoading.dismiss();
    });
  }

  Future<void> manageRequest({type, courseTitle, uid, rid}) async {
    emit(MainLoading());
    EasyLoading.show(status: 'Loading...');
    await MainApi()
        .manageRequest(type: type, courseTitle: courseTitle, uid: uid, rid: rid)
        .then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        clearCont();
        fetchTutorData();
      } else {
        emit(MainFailure(res['message']));
      }
      EasyLoading.dismiss();
    });
  }

  Future<void> createLecture() async {
    emit(MainLoading());
    EasyLoading.show(status: 'Loading...');
    await LocationService().currentLocation();
    await MainApi()
        .createLecture(
            courseId: selectedCourse!.id,
            courseTitle: selectedCourse!.title,
            lectureTitle: codeCont.text.trim(),
            qrDuration: selectedDuration)
        .then((res) {
      if (res == 'error' || res == null) {
        emit(MainFailure('Check internet connection.'));
      } else if (res['success'] == true) {
        emit(MainGenQr(
          '${codeCont.text.trim().hashCode + 90}${selectedCourse!.title.hashCode + 10}${currentDay.hashCode + 5}${selectedCourse!.id.hashCode + 9}',
        ));
        clearCont();
        fetchTutorData();
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

  pickImage() async {
    if (pickedImage == null) {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      pickedImage = null;
    }
  }

  updateProfileImage() async {
    emit(MainLoading());
    await pickImage();
    if (pickedImage != null) {
      CachedNetworkImage.evictFromCache(tutorModel != null
          ? tutorModel!.tutorInfo!.image!
          : studentModel!.userInfo!.image!);
      EasyLoading.show(status: 'Loading...');
      await MainApi().updateProfileImage(path: pickedImage!.path).then((res) {
        if (res == 'error' || res == null) {
          emit(MainFailure('Check internet connection.'));
        } else if (res['success'] == true) {
          emit(MainSuccess());
          clearCont();
          fetchTutorData();
        } else {
          emit(MainFailure(res['message']));
        }
        EasyLoading.dismiss();
      });
    }
  }

  refreshState() {
    emit(MainInitial());
  }

  clearCont() {
    codeCont.clear();
    idCont.clear();
    startDate = '';
    endDate = '';
    selectedDays.clear();
    selectedHours.clear();
    pickedImage = null;
    selectedDuration = '';
  }

  void initialize(context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (AppShared.localStorage.getBool('active') == true) {
        if (AppShared.localStorage.getString('userType') == 'student') {
          fetchStudentData();
        } else {
          fetchTutorData();
        }

        List<String> myNotes =
            AppShared.localStorage.getStringList('notes')!.cast<String>();
        myNotes.add(message.notification!.title!);
        AppShared.localStorage.setStringList('notes', myNotes);
        List<String> notesDates =
            AppShared.localStorage.getStringList('notes_dates')!.cast<String>();
        notesDates.add(DateFormat.yMd().format(DateTime.now()));
        AppShared.localStorage.setStringList('notes_dates', notesDates);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (AppShared.localStorage.getBool('active') == true) {
        if (AppShared.localStorage.getString('userType') == 'student') {
          fetchStudentData();
        } else {
          fetchTutorData();
        }
      }
    });
    emit(MainInitial());
  }
}

String currentDay = '';
