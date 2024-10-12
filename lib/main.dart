import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mohadraty/src/app_root.dart';
import 'package:mohadraty/src/app_shared.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: 'assets/env/.env');
  await AppShared.init();
  // await AppShared.localStorage.setBool('active', false);
  // await AppShared.localStorage.setBool('onboarded', false);
  runApp(const AppRoot());
}
