import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mohadraty/services/overrides.dart';
import 'package:mohadraty/src/app_root.dart';
import 'package:mohadraty/src/app_shared.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
// Replace with actual values
      options: const FirebaseOptions(
    apiKey: "AIzaSyCQi4DL4edtfjTRloi5nK0ih3_wZjCWAWc",
    appId: "1:295908173417:web:38ba95b20a2d6bdc38a4f8",
    messagingSenderId: "295908173417",
    projectId: "mohadraty-2b6f9",
  ));
  kIsWeb ? null : await dotenv.load(fileName: 'assets/env/.env');
  await AppShared.init();
  // await AppShared.localStorage.setBool('active', false);
  // await AppShared.localStorage.setBool('onboarded', false);
  // await AppShared.localStorage.setStringList('notes_dates', []);
  // await AppShared.localStorage.setStringList('notes', []);
  runApp(const AppRoot());
}
