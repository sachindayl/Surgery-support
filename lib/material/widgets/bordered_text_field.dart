import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  final String? placeholder;
  final TextInputType? textInputType;
  final bool? obscureText;

  BorderedTextField({this.placeholder, this.textInputType, this.obscureText});

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
        ));
  }
}
