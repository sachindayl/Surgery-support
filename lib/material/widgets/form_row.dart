import 'package:flutter/material.dart';

import '../material_styles.dart';

class FormRow extends StatelessWidget {
  final Icon? icon;
  final Widget formField;

  FormRow({this.icon, required this.formField});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MaterialStyles.iconSizedBoxWidth,
          child: icon ?? Container(),
        ),
        Expanded(
          child: formField,
        ),
      ],
    );
  }
}
