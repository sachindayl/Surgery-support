import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:surgery_support/cupertino/views/create_patient/personal_info_view.dart';

class PatientSearchView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text('Search'),
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
      ],
    );
  }
}