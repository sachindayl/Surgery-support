import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:surgery_support/cupertino/app_main.dart';
import 'package:surgery_support/material/app_main.dart';

final app = Platform.isIOS ? CupertinoAppMain() : MaterialAppMain();

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      //Catching exceptions in the flutter framework
      log('Error From FLUTTER FRAME_WORK');
      log('----------------------');
      log('Error :  ${details.exception}');
      log('StackTrace :  ${details.stack}');
    };

    runApp(EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('si', 'LK')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: app));
  } catch (e) {
    log(e.toString(), name: "main");
  }
}
