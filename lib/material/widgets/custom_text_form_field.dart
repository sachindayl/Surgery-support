import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final Function()? onTap;

  CustomTextFormField({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      onTap: onTap,
    );
  }
}