import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification.dart';

class AppShared {
  static late SharedPreferences localStorage;
  static late PackageInfo appInfo;
  static Future<void> init() async {
    appInfo = await PackageInfo.fromPlatform();
    localStorage = await SharedPreferences.getInstance();
    localStorage.getStringList('levels') == null
        ? localStorage.setStringList('levels', [])
        : null;
    localStorage.getBool('active') == null
        ? localStorage.setBool('active', false)
        : NotificationService.initFCM();
    localStorage.getBool('onboarded') == null
        ? localStorage.setBool('onboarded', false)
        : null;
    localStorage.getBool('subs') == null
        ? localStorage.setBool('subs', true)
        : null;
    localStorage.getString('token') == null
        ? localStorage.setString('token', '')
        : null;
  }
}
