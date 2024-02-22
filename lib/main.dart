import 'package:chat_app_fb/services/auth/auth_gate.dart';
import 'package:chat_app_fb/firebase_options.dart';
import 'package:chat_app_fb/themes/light_mode.dart';
import 'package:chat_app_fb/view/login_or_register.dart';
import 'package:chat_app_fb/view/login_page.dart';
import 'package:chat_app_fb/view/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: lightMode,
    );
  }
}
