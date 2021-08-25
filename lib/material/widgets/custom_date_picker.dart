import 'package:flutter/material.dart';

class CustomDatePicker {
  final DateTime selectedDate;
  final Function(DateTime) newDateCallback;

  CustomDatePicker({required this.selectedDate, required this.newDateCallback});

  Future<void> build(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      newDateCallback(picked);
    }
  }
}
