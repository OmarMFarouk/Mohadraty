import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/services/location.dart';
import 'package:mohadraty/src/app_endpoints.dart';
import 'package:mohadraty/src/app_shared.dart';

class MainApi {
  Future fetchStudentData() async {
    try {
      var request = await http.post(Uri.parse(AppEndPoints.studentData), body: {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'email': AppShared.localStorage.getString('email')
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future fetchTutorData() async {
    try {
      var request = await http.post(Uri.parse(AppEndPoints.tutorData), body: {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'email': AppShared.localStorage.getString('email')
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future joinClass(
      {required String courseCode, required String studentId}) async {
    try {
      var request = await http.post(Uri.parse(AppEndPoints.joinClass), body: {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'user_id': studentModel!.userInfo!.id,
        'course_code': courseCode,
        'student_id': studentId,
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future attendClass(qrCode) async {
    await LocationService().currentLocation();
    try {
      var request = await http.post(Uri.parse(AppEndPoints.attendClass), body: {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'user_id': studentModel!.userInfo!.id,
        'qr_code': qrCode,
        'user_location':
            '${LocationService.userLocation!.latitude},${LocationService.userLocation!.longitude}'
      });
      log(request.body);
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future createClass(
      {required String courseCode,
      required String classTitle,
      required String endDate,
      required String startDate,
      required String weekHours,
      required String weekDays,
      path}) async {
    try {
      Map<String, String> data = {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']!
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'tutor_id': tutorModel!.tutorInfo!.id!,
        'course_title': classTitle,
        'course_code': courseCode,
        'start_date': startDate,
        'end_date': endDate,
        'week_hours': weekHours,
        'week_days': weekDays,
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppEndPoints.createClass),
      );
      request.fields.addAll(data);

      var multipartFile = await http.MultipartFile.fromPath(
          'file', path); //returns a Future<MultipartFile>
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonData = await jsonDecode(respStr);
      if (response.statusCode < 300) {
        return jsonData;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future manageRequest({uid, rid, courseTitle, type}) async {
    try {
      var request =
          await http.post(Uri.parse(AppEndPoints.manageReqeust), body: {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'course_title': courseTitle,
        'rid': rid,
        'user_id': uid,
        'enrolment_status': type
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future createLecture(
      {lectureTitle, courseId, courseTitle, qrDuration}) async {
    try {
      var request =
          await http.post(Uri.parse(AppEndPoints.createLecture), body: {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'course_title': courseTitle,
        'lecture_title': lectureTitle,
        'course_id': courseId,
        'qr_duration': qrDuration,
        'qr_code':
            '${lectureTitle.hashCode + 90}${courseTitle.hashCode + 10}${currentDay.hashCode + 5}${courseId.hashCode + 9}',
        'location':
            '${LocationService.userLocation!.latitude},${LocationService.userLocation!.longitude}'
      });
      log(request.body);
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateProfileImage({path}) async {
    try {
      Map<String, String> data = {
        'api_sk': kIsWeb
            ? dotenv.env['api_sk']!
            : 'd3a0d6f3c7cdf0edcb64c66e74792f033f7da50b',
        'user_email': AppShared.localStorage.getString('email')!,
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppEndPoints.updateImage),
      );
      request.fields.addAll(data);

      var multipartFile = await http.MultipartFile.fromPath(
          'file', path); //returns a Future<MultipartFile>
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonData = await jsonDecode(respStr);
      if (response.statusCode < 300) {
        return jsonData;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
