import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  final String? placeholder;
  final TextInputType? textInputType;
  final bool? obscureText;
  final TextEditingController? controller;

  BorderedTextField(
      {this.placeholder,
      this.textInputType,
      this.obscureText,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: placeholder,
      ),
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      controller: controller,
    ));
  }
}
