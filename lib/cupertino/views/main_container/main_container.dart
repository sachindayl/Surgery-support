import 'package:flutter/cupertino.dart';
import 'package:surgery_support/cupertino/views/home/home_view.dart';
import 'package:surgery_support/cupertino/views/patient_search/patient_search_view.dart';
import 'package:surgery_support/shared/viewmodels/main_container_viewmodel.dart';
import 'package:provider/provider.dart';

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: context
            .select((MainContainerViewModel viewModel) => viewModel.viewIndex),
        onTap: (index) =>
            context.read<MainContainerViewModel>().setViewIndex(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet_below_rectangle),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Patient search',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => _tabs[context.select(
              (MainContainerViewModel viewModel) => viewModel.viewIndex)],
        );
      },
    );
  }

  final List<Widget> _tabs = [HomeView(), PatientSearchView()];
}
