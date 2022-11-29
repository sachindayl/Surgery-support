import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';

class MessageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Styles.white,
          borderRadius: BorderRadius.circular(Styles.itemBorderRadius)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: const Text('No events to display.'),
    );
  }
}
