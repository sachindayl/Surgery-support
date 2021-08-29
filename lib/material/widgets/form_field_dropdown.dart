import 'package:flutter/material.dart';

class FormFieldDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> listItems;
  final Function(dynamic) onChangedCallback;

  FormFieldDropdown(
      {required this.label, required this.value, required this.listItems, required this.onChangedCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        items: listItems.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChangedCallback,
      ),
    );
  }
}