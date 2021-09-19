import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
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
            SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                onStretchTrigger: () async {},
                expandedHeight: 100.0,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text('Patient search',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Styles.white))),),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: TextField(
                        style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Styles.white,),
                          hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (searchTerm) => context
                          .read<PatientHistoryViewModel>()
                          .setSearchTerm(searchTerm),
                    ),
                  ),
                ),
              )
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: PatientListItem(
                      patient: context
                          .watch<PatientHistoryViewModel>()
                          .patientsList[index]),
                ),
                childCount: context
                    .watch<PatientHistoryViewModel>()
                    .patientsList
                    .length,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
