import 'package:flutter/material.dart';

class FormFieldDropdown extends StatelessWidget {
  final String label;
  final List<String> listItems;

  FormFieldDropdown({required this.label, required this.listItems});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
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
        onChanged: (_) {},
      ),
    );
  }
}