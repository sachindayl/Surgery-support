import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/base/constants/constants.dart';

import '../cupertino_styles.dart';

class CustomPicker extends StatelessWidget {
  final String? title;
  final Function(int) onSelectedItemChanged;
  final List<String> itemList;
  final int selectedIndex;

  CustomPicker(
      {this.title,
      required this.onSelectedItemChanged,
      required this.itemList,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        title != null
            ? Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Styles.white,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  title ?? Constants.emptyString,
                  style: TextStyle(
                      fontSize: Styles.fontSize21,
                      fontWeight: Styles.fontWeightSemiBold),
                ),
              )
            : Container(),
        Container(
          height: 250.0,
          child: CupertinoPicker.builder(
            scrollController:
                FixedExtentScrollController(initialItem: selectedIndex),
            backgroundColor: Styles.white,
            onSelectedItemChanged: onSelectedItemChanged,
            itemExtent: 64.0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  itemList[index],
                  style: CupertinoStyles.blackBodyText2.copyWith(
                      color: Styles.black.withOpacity(Styles.opacity87)),
                ),
              );
            },
            childCount: itemList.length,
          ),
        ),
      ],
    );
  }
}
