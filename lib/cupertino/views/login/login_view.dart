import 'package:flutter/cupertino.dart';
import 'package:surgery_support/base/base_styles.dart';
import 'package:surgery_support/cupertino/cupertino_styles.dart';
import 'package:surgery_support/cupertino/views/main_container/main_container.dart';
import 'package:surgery_support/cupertino/widgets/bordered_text_field.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
      color: Styles.primaryColor,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Styles.primaryColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
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
                      'Welcome back',
                      style: TextStyle(
                          fontSize: Styles.fontSize36,
                          fontWeight: Styles.fontWeightBold,
                          color: CupertinoTheme.of(context).primaryColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 16),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: BorderedTextField(
                      placeholder: 'Password',
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
                              color: CupertinoStyles.lightTheme.primaryColor),
                        )),
                        CupertinoButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(CupertinoPageRoute(
                                  builder: (context) => MainContainer())),
                          child: Icon(
                            CupertinoIcons.right_chevron,
                            color: Styles.white,
                          ),
                          color: Styles.accentColor,
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
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
    ));
  }
}
