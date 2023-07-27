import 'package:flutter/material.dart';
import 'package:login/model/user.dart';

class TextFieldLogIn extends StatelessWidget {
  final String text;
  final Icon icon;
  final bool obscureText;
  final TextEditingController controller;
  const TextFieldLogIn({
    super.key,
    required this.text,
    required this.icon,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            if (value!.isEmpty) {
              return '$text is required';
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.green, width: 1)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.green, width: 2)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2)),
            icon: icon,
            labelText: text,
            labelStyle: const TextStyle(color: Colors.green),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
          
          onSaved: (value) {
            if (text == 'Email') {
              controller.text = value!;
            } else if (text == 'Password') {
              controller.text = value!;
            }
          },
          ),
    );
  }
}
