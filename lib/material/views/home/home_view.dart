import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/widgets/custom_calendar.dart';
import 'package:wardeleven/material/widgets/custom_card.dart';
import 'package:wardeleven/shared/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CustomCard(
                  child: CustomCalendar(
                      context.read<HomeViewModel>().events, (date) => '')),
            ),
            Expanded(
                flex: 2,
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Styles.itemBorderRadius, vertical: 8.0),
                    child: Card(
                      child: Column(
                        children: [Text('Patients')],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
