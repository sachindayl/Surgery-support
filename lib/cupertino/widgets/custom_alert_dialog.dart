import 'package:flutter/cupertino.dart';

import '../cupertino_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  CustomAlertDialog(
      {required this.title, this.content = '', required this.actions});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: CupertinoStyles.blackBodyText2,
        ),
        actions: actions);
  }
}
