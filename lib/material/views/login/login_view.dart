import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/main_container/main_container.dart';
import 'package:wardeleven/material/widgets/bordered_text_field.dart';

import '../../material_styles.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Styles.primaryColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                color: Styles.primaryColor,
                child: SizedBox(
                  height: 250,
                ),
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
                        'Welcome back',
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
                                color: MaterialStyles.lightTheme.primaryColor),
                          )),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => MainContainer())),
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
    ));
  }
}
