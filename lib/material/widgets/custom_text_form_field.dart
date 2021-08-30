import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;

  CustomTextFormField(
      {required this.label, this.initialValue,this.controller , this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      controller: controller,
      initialValue:initialValue,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}