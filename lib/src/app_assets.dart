import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppAssets {
  static String appVersion = '1.0.0';
  static init(context) async {
    await dotenv.load(fileName: "assets/env/.env");
    final appInfo = await PackageInfo.fromPlatform();
    appVersion = appInfo.version;
    precacheImage(AssetImage(ideaIllu), context);
    precacheImage(AssetImage(qrSuccessGIF), context);
    precacheImage(AssetImage(failGIF), context);
    precacheImage(AssetImage(scanGIF), context);
    precacheImage(AssetImage(addClassIcon), context);
    precacheImage(AssetImage(scanQrIcon), context);
  }

  // Paths
  static String iconPath = 'assets/images/icons';
  static String illuPath = 'assets/images/illustrations';
  static String gifPath = 'assets/images/gifs';

  // Icons
  static String addClassIcon = '$iconPath/add_class.png';
  static String scanQrIcon = '$iconPath/scan_qr.png';

  // Illustrations
  static String logo = '$illuPath/logo.PNG';
  static String ideaIllu = '$illuPath/idea.png';
  static String attendanceIllu = '$illuPath/attendance.png';
  static String timeIllu = '$illuPath/time.png';
  static String freeIllu = '$illuPath/free.png';

  // Gifs
  static String qrSuccessGIF = '$gifPath/qr_success.gif';
  static String failGIF = '$gifPath/fail.gif';
  static String loadingGIF = '$gifPath/loading.gif';
  static String scanGIF = '$gifPath/scan.gif';
}
