import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/services/location.dart';
import 'package:mohadraty/src/app_endpoints.dart';
import 'package:mohadraty/src/app_shared.dart';

class MainApi {
  static String baseUrl = 'https://joker-cash.com/mohadraty/public';
  Future fetchMainData() async {
    try {
      var request = await http.post(Uri.parse(AppEndPoints.userData), body: {
        'api_sk': dotenv.env['api_sk'],
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
        'api_sk': dotenv.env['api_sk'],
        'user_id': mainModel!.userInfo!.id,
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
        'api_sk': dotenv.env['api_sk'],
        'user_id': mainModel!.userInfo!.id,
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
}
