import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../src/app_endpoints.dart';
import '../../src/app_shared.dart';

class AuthApi {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future register({
    required password,
    required name,
    required email,
  }) async {
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;
    String deviceId;
    String deviceDetails;
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;

      deviceId = androidInfo.id;
      deviceDetails =
          '${androidInfo.model} - Android:${androidInfo.version.release}';
    } else {
      iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor!;
      deviceDetails = '${iosInfo.model} - IOS:${iosInfo.systemVersion}';
    }

    try {
      var request = await http.post(Uri.parse(AppEndPoints.register), body: {
        'api_sk': dotenv.env['api_sk'],
        'name': name,
        'password': password,
        'email': email,
        'device_id': deviceId,
        'device_info': deviceDetails,
        'fcm_token': AppShared.localStorage.getString('token')
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

  Future login({
    required password,
    required email,
  }) async {
    try {
      var request = await http.post(Uri.parse(AppEndPoints.login), body: {
        'api_sk': dotenv.env['api_sk'],
        'password': password,
        'email': email,
        'fcm_token': AppShared.localStorage.getString('token')
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
