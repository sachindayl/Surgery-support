import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType textInputType;
  final int? maxLength;
  final FormFieldValidator<String>? validator;

  CustomTextFormField(
      {required this.label,
      this.initialValue,
      this.controller,
      this.onChanged,
      this.onTap,
      this.textInputType = TextInputType.text,
      this.maxLength,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        counterText: ""
      ),
      textCapitalization: TextCapitalization.characters,
      keyboardType: textInputType,
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      onTap: onTap,
      maxLength: maxLength,
      validator: validator,
    );
  }
}
