import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:surgery_support/material/views/login_view.dart';
import 'package:surgery_support/shared/viewmodels/login_viewmodel.dart';

import 'material_styles.dart';

class MaterialAppMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginViewModel())],
      child: MaterialApp(
        title: 'Surgery Support',
        theme: MaterialStyles.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: LoginView(),
      ),
    );
  }
}
