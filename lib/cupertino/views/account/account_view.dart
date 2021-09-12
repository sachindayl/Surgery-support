import 'package:flutter/cupertino.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/cupertino/views/login/login_view.dart';
import 'package:wardeleven/cupertino/widgets/custom_circular_progress_indicator.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/shared/viewmodels/login_viewmodel.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.select((LoginViewModel viewModel) =>
        viewModel.isSignedOut == DataState.success)) {
      _signOutUser(context);
    }

    return Stack(
      children: [
        CustomScrollView(slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Account'),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 80.0,
              margin: const EdgeInsets.symmetric(vertical: 32.0),
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton(
                onPressed: () async {
                  var viewmodel = context.read<LoginViewModel>();
                  viewmodel.setLoadingState(LoadingState.loading);
                  await viewmodel.signOutUser();
                  viewmodel.setLoadingState(LoadingState.complete);
                },
                color: CupertinoTheme.of(context).primaryColor,
                child: Text(
                  'Sign out',
                  style: TextStyle(color: Styles.white),
                ),
              ),
            ),
          )
        ]),
        CustomCircularProgressIndicator(
            isLoading: context.watch<LoginViewModel>().loadingState)
      ],
    );
  }

  _signOutUser(BuildContext context) {
    Future.microtask(() async {
      context.read<LoginViewModel>().clearData();
      return await Navigator.of(context, rootNavigator: true).pushReplacement(
          CupertinoPageRoute(builder: (context) => LoginView()));
    });
  }
}
