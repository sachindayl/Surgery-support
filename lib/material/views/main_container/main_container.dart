import 'package:flutter/material.dart';
import 'package:surgery_support/base/base_styles.dart';

import '../create_patient/create_patient_view.dart';
import '../home/home_view.dart';

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar:
              TabBar(labelColor: Colors.black, tabs: _tabs(context)),
          body: TabBarView(children: [HomeView(), CreatePatientView()]),
          floatingActionButton: ElevatedButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreatePatientView())),
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
