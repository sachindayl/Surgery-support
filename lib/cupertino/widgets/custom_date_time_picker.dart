import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';

class CustomDateTimePicker extends StatelessWidget {
  final bool isDate;
  final DateTime value;
  final Function(DateTime) valueCallback;
  final DateTime maxDate;
  final DateTime minDate;

  CustomDateTimePicker(
      {required this.isDate,
      required this.value,
      required this.valueCallback,
      required this.maxDate,
      required this.minDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Styles.white,
      child: Column(
        children: [
          Container(
            height: 300,
            child: CupertinoDatePicker(
                maximumDate: maxDate,
                minimumDate: minDate,
                mode: isDate
                    ? CupertinoDatePickerMode.date
                    : CupertinoDatePickerMode.time,
                initialDateTime: value,
                onDateTimeChanged: (newValue) {
                  valueCallback(newValue);
                }),
          ),

          // Close the modal
          CupertinoButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
