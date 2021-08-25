import 'package:flutter/material.dart';
import 'package:surgery_support/base/base_styles.dart';

class FormTitle extends StatelessWidget {
  final String title;

  FormTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 24.0),
      child: Text(
        title,
        style: TextStyle(
            color: Styles.black.withOpacity(Styles.opacity87),
            fontSize: Styles.fontSize19,
            fontWeight: Styles.fontWeightSemiBold
        ),
      ),
    );
  }
}