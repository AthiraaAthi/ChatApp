import 'package:chat_app_fb/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../components/my_buttons.dart';
import '../components/my_textfields.dart';

class RegisterPage extends StatelessWidget {
  //tap for login
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});
  //controllers for both email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();

  //register method --1
  void register(BuildContext context) async {
    //get auth service ---2
    final authservice = AuthService();

    //passwords match => create user
    if (passController.text == confirmpassController.text) {
      try {
        authservice.signUpWithEmailPassword(
            emailController.text, passController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //passwords dont match => tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message_rounded,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: 50,
            ),

            //welcome back message
            Text(
              "Let's Create an Account",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),

            //email textfield
            MyTextFields(
              controller: emailController,
              obscure: false,
              hintText: "Enter your email",
            ),
            SizedBox(
              height: 10,
            ),

            //pass textfield
            MyTextFields(
              controller: passController,
              obscure: true,
              hintText: "Enter your Password",
            ),
            SizedBox(
              height: 10,
            ),
            //confirm pass textfield
            MyTextFields(
              controller: confirmpassController,
              obscure: true,
              hintText: "Confirm Password",
            ),
            SizedBox(
              height: 25,
            ),

            //login button
            MyButtons(
              onTap: () => register(context),
              text: "Register",
            ),
            SizedBox(
              height: 25,
            ),

            //reg now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                InkWell(
                  onTap: onTap,
                  child: Text("Login now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
