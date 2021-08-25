import 'package:flutter/material.dart';
import 'package:surgery_support/base/base_styles.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(child: Placeholder(
          color: Styles.accentColor,
        )),
        Expanded(
            flex: 2,
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: Styles.itemBorderRadius, vertical: 16.0),
                child: Card(
                  child: Column(
                    children: [
                      Text('Patients')
                    ],
                  ),
                )
            ))
      ],
    );
  }
}
