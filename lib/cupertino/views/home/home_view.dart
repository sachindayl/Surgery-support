import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wardeleven/cupertino/views/create_patient/personal_info_view.dart';
import 'package:wardeleven/cupertino/widgets/custom_calendar.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/shared/viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text(''),
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
      SliverToBoxAdapter(
        child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomCalendar(context.read<HomeViewModel>().events, (date) => ''),
            ),
      )
    ]);
  }
}
