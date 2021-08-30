import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/widgets/custom_calendar.dart';
import 'package:wardeleven/material/widgets/custom_card.dart';
import 'package:wardeleven/material/widgets/message_tile.dart';
import 'package:wardeleven/material/widgets/patient_list_item.dart';
import 'package:wardeleven/shared/viewmodels/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<HomeViewModel>().getMonthlyPatients();
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
              title: Text('Recent'),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: CustomCard(
                    child: CustomCalendar(
                        context.read<HomeViewModel>().calenderEvents,
                        (selectedDay) => context
                            .read<HomeViewModel>()
                            .setSelectedDay(selectedDay),
                        (focusedDay) => context
                            .read<HomeViewModel>()
                            .setFocusedDay(focusedDay))),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'High priority surgeries',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            context.watch<HomeViewModel>().todayHighPriorityPatients.isNotEmpty ?
                SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      child: PatientListItem(
                          patient: context
                              .watch<HomeViewModel>()
                              .todayHighPriorityPatients[index]
                      ),
                    ),
                  childCount: context
                      .watch<HomeViewModel>()
                      .todayHighPriorityPatients.length,
                )): SliverToBoxAdapter(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Styles.itemBorderRadius, vertical: 8.0),
                  child: MessageTile()),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 4.0),
                child: Text(
                  'Surgeries',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            context.watch<HomeViewModel>().todayOtherPatients.isNotEmpty ?
            SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: PatientListItem(
                    patient: context
                        .watch<HomeViewModel>()
                        .todayOtherPatients[index]
                ),
              ),
              childCount: context
                  .watch<HomeViewModel>()
                  .todayOtherPatients.length,
            )): SliverToBoxAdapter(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Styles.itemBorderRadius, vertical: 4.0),
                  child: MessageTile()),
            ),
          ],
        ),
      ),
    );
  }
}
