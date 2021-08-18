import 'package:app/cupertino/cupertino_styles.dart';
import 'package:app/cupertino/views/login_view.dart';
import 'package:app/shared/viewmodels/login_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CupertinoAppMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel())
      ],
      child: CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoStyles.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: LoginView(),
      ),
    );
  }
}
