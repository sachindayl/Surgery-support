import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/cupertino/cupertino_styles.dart';
import 'package:wardeleven/cupertino/views/create_patient/create_patient_view.dart';
import 'package:wardeleven/cupertino/widgets/custom_calendar.dart';
import 'package:wardeleven/cupertino/widgets/message_tile.dart';
import 'package:wardeleven/cupertino/widgets/patient_list_item.dart';
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
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text('Ward Eleven'),
        trailing: GestureDetector(
          onTap: () => showCupertinoModalBottomSheet(
              useRootNavigator: true,
              elevation: 5.0,
              expand: true,
              context: context,
              builder: (context) =>
                  CreatePatientView(updateSuccessful: (isUpdated) async {
                    if (isUpdated) {
                      await context.read<HomeViewModel>().getMonthlyPatients();
                    }
                  })),
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(CupertinoIcons.person_add)),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomCalendar(
              context.watch<HomeViewModel>().selectedDay,
              context.watch<HomeViewModel>().focusedDay,
              context.watch<HomeViewModel>().calenderEvents,
              (selectedDay) =>
                  context.read<HomeViewModel>().setSelectedDay(selectedDay),
              (focusedDay) =>
                  context.read<HomeViewModel>().setFocusedDay(focusedDay)),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'High priority surgeries',
            style: CupertinoStyles.mainTitleText,
          ),
        ),
      ),
      context.watch<HomeViewModel>().todayHighPriorityPatients.isNotEmpty
          ? SliverList(
              delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: PatientListItem(
                    patient: context
                        .watch<HomeViewModel>()
                        .todayHighPriorityPatients[index],
                    isUpdateSuccessful: (isUpdated) async {
                      if (isUpdated) {
                        await context
                            .read<HomeViewModel>()
                            .getMonthlyPatients();
                      }
                    }),
              ),
              childCount: context
                  .watch<HomeViewModel>()
                  .todayHighPriorityPatients
                  .length,
            ))
          : SliverToBoxAdapter(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: MessageTile()),
            ),
      SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Surgeries',
            style: CupertinoStyles.mainTitleText,
          ),
        ),
      ),
      context.watch<HomeViewModel>().todayOtherPatients.isNotEmpty
          ? SliverList(
              delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: PatientListItem(
                    patient: context
                        .watch<HomeViewModel>()
                        .todayOtherPatients[index],
                    isUpdateSuccessful: (isUpdated) async {
                      if (isUpdated) {
                        await context
                            .read<HomeViewModel>()
                            .getMonthlyPatients();
                      }
                    }),
              ),
              childCount:
                  context.watch<HomeViewModel>().todayOtherPatients.length,
            ))
          : SliverToBoxAdapter(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: MessageTile()),
            ),
    ]);
  }
}
