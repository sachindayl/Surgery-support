import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';

class FormTitle extends StatelessWidget {
  final String title;

  FormTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 16.0),
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