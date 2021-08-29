import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String initialValue;
  final Function(String) onChanged;
  final Function()? onTap;

  CustomTextFormField(
      {required this.label, required this.initialValue, required this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      initialValue:initialValue,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}