import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';

class CustomCupertinoSearchTextField extends StatelessWidget {
  final Function(String) searchTerm;

  CustomCupertinoSearchTextField({required this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      itemColor: Styles.white,
      placeholderStyle: TextStyle(color: Styles.white),
      style: TextStyle(color: Styles.white),
      backgroundColor: Styles.primaryColor,
      onChanged: (value) => searchTerm(value),
    );
  }
}
