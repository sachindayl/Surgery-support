import 'dart:developer';
import 'dart:io';

import 'package:app/cupertino/app_main.dart';
import 'package:app/material/app_main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        supportedLocales: [Locale('en', 'US'), Locale('it', 'IT')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: app));
  } catch (e) {
    log(e.toString(), name: "main");
  }
}
