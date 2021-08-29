import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/patient_search/patient_search_view.dart';

import '../create_patient/personal_info_view.dart';
import '../home/home_view.dart';

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar:
              TabBar(labelColor: Colors.black, tabs: _tabs(context)),
          body: TabBarView(children: [HomeView(), PatientSearchView()]),
          floatingActionButton: ElevatedButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PersonalInfoView())),
            child: Icon(Icons.person_add),
            style: ElevatedButton.styleFrom(
                primary: Styles.accentColor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(16.0)),
          ),
        ));
  }

  List<Widget> _tabs(BuildContext context) => [
        Tab(
          icon: Icon(
            Icons.home_filled,
            color: IconTheme.of(context).color,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.person_search,
            color: IconTheme.of(context).color,
          ),
        ),
      ];
}
