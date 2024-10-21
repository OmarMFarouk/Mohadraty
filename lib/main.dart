import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mohadraty/firebase_options.dart';
import 'package:mohadraty/services/overrides.dart';
import 'package:mohadraty/src/app_root.dart';
import 'package:mohadraty/src/app_shared.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: 'assets/env/.env');
  await AppShared.init();
  // await AppShared.localStorage.setBool('active', false);
  // await AppShared.localStorage.setBool('onboarded', false);
  // await AppShared.localStorage.setStringList('notes_dates', []);
  // await AppShared.localStorage.setStringList('notes', []);
  runApp(const AppRoot());
}
