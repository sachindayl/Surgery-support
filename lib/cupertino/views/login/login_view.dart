import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/views/main_container/main_container.dart';
import 'package:wardeleven/cupertino/widgets/bordered_text_field.dart';
import 'package:wardeleven/cupertino/widgets/custom_circular_progress_indicator.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/shared/viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
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

    return Stack(
      children: [
        CupertinoPageScaffold(
            child: Container(
          color: Styles.primaryColor,
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: Styles.primaryColor,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(4.0),

                          width: 90.0,
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/logo_name.png', fit: BoxFit.contain,)),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
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
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: Styles.fontSize36,
                                fontWeight: Styles.fontWeightBold,
                                color: CupertinoTheme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Sign in to continue',
                            style: TextStyle(
                                fontSize: Styles.fontSize14,
                                color: Styles.black.withOpacity(0.6)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 60.0,
                        ),
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
                          obscureText: true,
                          controller: _passwordController,
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 40.0,
                        ),
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
                                  color:
                                      CupertinoTheme.of(context).primaryColor),
                            )),
                            CupertinoButton(
                              onPressed: () async {
                                var viewmodel = context.read<LoginViewModel>();
                                viewmodel.setLoadingState(LoadingState.loading);
                                await viewmodel
                                  .loginWithEmailPassword(_emailController.text,
                                      _passwordController.text);
                                viewmodel.setLoadingState(LoadingState.complete);
                              },
                              child: Icon(
                                CupertinoIcons.right_chevron,
                                color: Styles.white,
                              ),
                              color: Styles.accentColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                              padding: EdgeInsets.all(16.0),
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
        )),
        CustomCircularProgressIndicator(
            isLoading: context.watch<LoginViewModel>().loadingState)
      ],
    );
  }

  _logInUser() async {
    await Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => MainContainer()));
  }
}
