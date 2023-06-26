import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/screens/auth/login_screen.dart';
import 'package:test_app/screens/home_screen.dart';
import 'package:test_app/screens/log_screen.dart';
import 'package:test_app/utils/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'yahsua-c6653',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        Routes().loginscreen: (context) => LoginScreen(),
        Routes().homescreen: (context) => HomeScreen(),
        Routes().logscreen: (context) => LogScreen()
      },
    );
  }
}
