import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/login/login_view.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/shared/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.select((LoginViewModel viewModel) =>
    viewModel.isSignedOut == DataState.success)) {
      _signOutUser(context);
    }
    return Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
            child: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            onStretchTrigger: () async {},
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text('Account',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Styles.white))),
          ),
          SliverToBoxAdapter(
              child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(top: 16.0),
            height: 100.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/images/icon.png')),
          )),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: MaterialButton(
                    height: 50.0,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      await _launchUrl(
                          'https://sites.google.com/view/ward-eleven/privacy-policy');
                    },
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(color: Styles.white),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: MaterialButton(
                    height: 50.0,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      await _launchUrl(
                          'https://sites.google.com/view/ward-eleven/terms-and-conditions');
                    },
                    child: Text(
                      'Terms and Conditions',
                      style: TextStyle(color: Styles.white),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: MaterialButton(
                    height: 50.0,
                    onPressed: () async {
                      var viewmodel = context.read<LoginViewModel>();
                      viewmodel.setLoadingState(LoadingState.loading);
                      await viewmodel.signOutUser();
                      viewmodel.setLoadingState(LoadingState.complete);
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Sign out',
                      style: TextStyle(color: Styles.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Powered by',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: Styles.fontSize14,
                        fontWeight: Styles.fontWeightSemiBold),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: Image.asset(
                    'assets/images/ts-logo.png',
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          )),
        ])));
  }

  _signOutUser(BuildContext context) {
    Future.microtask(() async {
      context.read<LoginViewModel>().clearData();
      return await Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginView()));
    });
  }

  Future<bool> _launchUrl(String url) async {
    return await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';
  }
}
