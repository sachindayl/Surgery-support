import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';

class BorderedTextField extends StatelessWidget {
  final String? placeholder;
  final TextInputType? textInputType;
  final bool? obscureText;

  BorderedTextField({this.placeholder, this.textInputType, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CupertinoTextField(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Styles.itemBorderRadius),
              border: Border.all(
                  width: 1.0, color: Styles.black.withOpacity(Styles.opacity51))),
          placeholder: placeholder,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: obscureText ?? false,
          padding: EdgeInsets.all(16.0),
        ));
  }
}
