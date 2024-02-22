import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  const MyTextFields(
      {super.key,
      required this.hintText,
      required this.obscure,
      required this.controller});
  final String hintText;
  final bool obscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true),
      ),
    );
  }
}
