import 'package:chat_app_fb/services/auth/auth_gate.dart';
import 'package:chat_app_fb/firebase_options.dart';
//import 'package:chat_app_fb/themes/light_mode.dart';
import 'package:chat_app_fb/themes/theme_provider.dart';
// import 'package:chat_app_fb/view/login_or_register.dart';
// import 'package:chat_app_fb/view/login_page.dart';
// import 'package:chat_app_fb/view/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themedata,
    );
  }
}
