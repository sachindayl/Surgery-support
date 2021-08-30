import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';

import 'custom_card.dart';

class MessageTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Styles.white,
          borderRadius: BorderRadius.circular(Styles.itemBorderRadius)
        ),
        padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0) ,
        child: const Text('No events to display.'),
      ),
    );
  }
}