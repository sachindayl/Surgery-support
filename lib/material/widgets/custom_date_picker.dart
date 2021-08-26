import 'package:flutter/material.dart';

class CustomDatePicker {
  final DateTime selectedDate;
  final Function(DateTime) newDateCallback;
  final DateTime firstDate;
  final DateTime lastDate;

  CustomDatePicker({required this.selectedDate, required this.newDateCallback,required this.firstDate,required this.lastDate});

  Future<void> build(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (picked != null && picked != selectedDate) {
      newDateCallback(picked);
    }
  }
}
