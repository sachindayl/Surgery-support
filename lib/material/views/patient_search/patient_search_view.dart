import 'package:flutter/material.dart';
import 'package:wardeleven/material/widgets/patient_list_item.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/shared/viewmodels/patient_history_viewmodel.dart';

class PatientSearchView extends StatefulWidget {
  @override
  _PatientSearchViewState createState() => _PatientSearchViewState();
}

class _PatientSearchViewState extends State<PatientSearchView> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<PatientHistoryViewModel>().getPatients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text('Patient search'), actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () {
                  /* ... */
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_alt),
                tooltip: 'Search',
                onPressed: () {
                  /* ... */
                },
              ),
            ]),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: PatientListItem(
                      patient: context
                          .watch<PatientHistoryViewModel>()
                          .patientsList[index]
                  ),
                ),
                childCount: context
                    .watch<PatientHistoryViewModel>()
                    .patientsList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
