import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/cupertino_styles.dart';
import 'package:wardeleven/cupertino/views/create_patient/create_patient_view.dart';
import 'package:wardeleven/cupertino/widgets/custom_calendar.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/shared/viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text('Ward Eleven'),
        trailing: GestureDetector(
          onTap: () => showCupertinoModalBottomSheet(
              useRootNavigator: true,
              elevation: 5.0,
              expand: true,
              context: context,
              builder: (context) => CreatePatientView()),
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(CupertinoIcons.person_add)),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomCalendar(
              context.read<HomeViewModel>().events, (date) => ''),
        ),
      ),
      SliverToBoxAdapter(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'High priority surgeries',
                style: CupertinoStyles.mainTitleText,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: Styles.itemBorderRadius, vertical: 8.0),
              child: Column(
                children: [],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Surgeries',
                style: CupertinoStyles.mainTitleText,
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: Styles.itemBorderRadius, vertical: 8.0),
                child: Column(
                  children: [],
                ))
          ],
        ),
      )
    ]);
  }
}
