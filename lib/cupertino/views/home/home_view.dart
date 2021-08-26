import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:surgery_support/cupertino/views/create_patient/personal_info_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text('Recents'),
        trailing: GestureDetector(
          onTap: () => showCupertinoModalBottomSheet(
            useRootNavigator: true,
            elevation: 5.0,
              expand: true,
              context: context,
              builder: (context) => PersonalInfoView()),
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(CupertinoIcons.person_add)),
        ),
      ),
      // SliverToBoxAdapter(
      //   child: Column(
      //     children: [
      //       Flexible(child: Placeholder(
      //         color: Styles.accentColor,
      //       )),
      //       Expanded(
      //           flex: 2,
      //           child: Container(
      //               width: double.infinity,
      //               padding: const EdgeInsets.symmetric(horizontal: Styles.itemBorderRadius, vertical: 16.0),
      //               child: Container(
      //                 color: Styles.white,
      //                 child: Column(
      //                   children: [
      //                     Text('Patients')
      //                   ],
      //                 ),
      //               )
      //           ))
      //     ],
      //   ),
      // )
    ]);
  }
}
