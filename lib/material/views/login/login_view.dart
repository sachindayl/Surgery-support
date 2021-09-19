import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/main_container/main_container.dart';
import 'package:wardeleven/material/widgets/bordered_text_field.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/shared/viewmodels/login_viewmodel.dart';

import '../../material_styles.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.select((LoginViewModel viewModel) =>
        viewModel.isLoggedIn == DataState.success)) {
      Future.delayed(Duration.zero, () async {
        await _logInUser();
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 0.0,
      ),
        body: SafeArea(
          child: SingleChildScrollView(
      child: Container(
          color: Styles.primaryColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Stack(
                  children: [
                    Container(
                      color: Styles.primaryColor,
                      child: SizedBox(
                        height: 250,
                      ),
                    ),
                    Center(
                      child: Container(
                          padding: const EdgeInsets.all(4.0),
                          margin: const EdgeInsets.only(top: 64.0),
                          width: 90.0,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/logo_name.png',
                            fit: BoxFit.contain,
                          )),
                    )
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 48.0),
                  decoration: BoxDecoration(
                      color: Styles.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24.0))),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: Styles.fontSize36,
                              fontWeight: Styles.fontWeightBold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Sign in to continue',
                          style: TextStyle(
                              fontSize: Styles.fontSize14,
                              color: Styles.black.withOpacity(0.6)),
                        ),
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: BorderedTextField(
                          placeholder: 'Email',
                          controller: _emailController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: BorderedTextField(
                          placeholder: 'Password',
                          controller: _passwordController,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: Styles.fontSize21,
                                  fontWeight: Styles.fontWeightSemiBold,
                                  color: MaterialStyles.lightTheme.primaryColor),
                            )),
                            ElevatedButton(
                              onPressed: () async {
                                context
                                    .read<LoginViewModel>()
                                    .setLoadingState(LoadingState.loading);
                                await context
                                    .read<LoginViewModel>()
                                    .loginWithEmailPassword(_emailController.text,
                                        _passwordController.text);
                                context
                                    .read<LoginViewModel>()
                                    .setLoadingState(LoadingState.complete);
                              },
                              child: Icon(
                                Icons.arrow_right_alt_rounded,
                                color: Styles.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Styles.accentColor,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(16.0)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    ),
        ));
  }

  _logInUser() async {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainContainer()));
  }
}
