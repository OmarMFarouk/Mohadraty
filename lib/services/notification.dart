import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../src/app_shared.dart';

Future<void> handleBackgroundMessage(RemoteMessage remoteMessage) async {
  // log('title ${remoteMessage.notification!.title}');
  // log('body ${remoteMessage.notification!.body}');
  // log('payload ${remoteMessage.data}');
}

class NotificationService {
  static final fcmInstance = FirebaseMessaging.instance;
  static const androidChannel = AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'important notifications', importance: Importance.max);
  static final localInstance = FlutterLocalNotificationsPlugin();

  static Future<void> initFCM() async {
    try {
      await fcmInstance.requestPermission(
          alert: true,
          sound: true,
          badge: true,
          announcement: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true);
      final fCMToken = await fcmInstance.getToken();
      await fcmInstance.subscribeToTopic('all');

      AppShared.localStorage.setString("token", "$fCMToken");
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.onMessage.listen((event) {
        final notification = event.notification;
        if (notification == null) return;
        localInstance.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    enableVibration: true,
                    importance: Importance.max,
                    priority: Priority.high,
                    androidChannel.id,
                    androidChannel.name,
                    channelDescription: androidChannel.description,
                    icon: '@mipmap/ic_launcher')));
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
