import 'package:flutter/cupertino.dart';

import 'custom_picker.dart';

class CustomFormFieldPicker extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final List<String> pickerList;
  final int pickerIndex;
  final Function(int) setNewIndex;
  final String? pickerTitle;

  CustomFormFieldPicker(
      {required this.controller,
      required this.pickerList,
      required this.pickerIndex,
      required this.setNewIndex,
      this.placeholder,
      this.pickerTitle});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      readOnly: true,
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
      controller: controller,
      placeholder: placeholder,
      onTap: () async => await showCupertinoModalPopup<int>(
          context: context,
          builder: (context) {
            return CustomPicker(
              title: pickerTitle,
              selectedIndex: pickerIndex,
              onSelectedItemChanged: (int newValue) {
                controller.text = pickerList[newValue];
                // viewModel.setTimeRangeIndex(newValue);
                setNewIndex(newValue);
              },
              itemList: pickerList,
            );
          }),
    );
  }
}
