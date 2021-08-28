import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  CustomCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Styles.itemBorderRadius),
      ),
      child: child,
    );
  }
}
