import 'package:chat_app_fb/view/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //check if the user is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          //user is not logged in
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
