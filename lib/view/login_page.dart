import 'package:chat_app_fb/auth/auth_service.dart';
import 'package:chat_app_fb/components/my_buttons.dart';
import 'package:chat_app_fb/components/my_textfields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //tap for register page
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});
  //controllers for both email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  //login method
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
          emailController.text, passController.text);
    }

    //catch any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
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
              "Welcome Back!",
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
              height: 25,
            ),

            //login button
            MyButtons(
              onTap: () => login(context),
              text: "Login",
            ),
            SizedBox(
              height: 25,
            ),

            //reg now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                InkWell(
                  onTap: onTap,
                  child: Text("Register now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
