import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wardeleven/cupertino/views/create_patient/create_patient_view.dart';
import 'package:wardeleven/cupertino/widgets/custom_search_text_field.dart';
import 'package:wardeleven/cupertino/widgets/patient_list_item.dart';

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
                builder: (context) => CreatePatientView()),
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(CupertinoIcons.person_add)),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: CustomCupertinoSearchTextField(searchTerm: (searchTerm) => '',),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: PatientListItem(),
                ),
            childCount: 10,
          ),
        )
      ],
    );
  }
}