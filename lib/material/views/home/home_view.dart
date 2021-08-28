import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/widgets/custom_calendar.dart';
import 'package:wardeleven/material/widgets/custom_card.dart';
import 'package:wardeleven/shared/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
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
                        context.read<HomeViewModel>().events, (date) => '')),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'High priority surgeries',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Styles.itemBorderRadius, vertical: 8.0),
                      child: CustomCard(
                        child: Column(
                          children: [

                          ],
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Surgeries',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Styles.itemBorderRadius, vertical: 8.0),
                      child: CustomCard(
                        child: Column(
                          children: [

                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
