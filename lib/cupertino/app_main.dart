import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wardeleven/cupertino/views/login/login_view.dart';
import 'package:wardeleven/cupertino/views/main_container/main_container.dart';
import 'package:wardeleven/shared/viewmodels/create_patient_viewmodel.dart';
import 'package:wardeleven/shared/viewmodels/home_viewmodel.dart';
import 'package:wardeleven/shared/viewmodels/login_viewmodel.dart';
import 'package:wardeleven/shared/viewmodels/main_container_viewmodel.dart';
import 'package:wardeleven/shared/viewmodels/patient_history_viewmodel.dart';

import 'cupertino_styles.dart';

class CupertinoAppMain extends StatelessWidget {
  final bool loginSuccessful;

  CupertinoAppMain(this.loginSuccessful);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => MainContainerViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CreatePatientViewmodel()),
        ChangeNotifierProvider(create: (_) => PatientHistoryViewModel()),
      ],
      child: CupertinoApp(
        title: 'Ward Eleven',
        theme: CupertinoStyles.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: loginSuccessful ? MainContainer() : LoginView(),
      ),
    );
  }
}
