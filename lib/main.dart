import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'cupertino/app_main.dart';
import 'material/app_main.dart';

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

    await Firebase.initializeApp();

    runApp(EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('si', 'LK')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: app));
  } catch (e) {
    log(e.toString(), name: "main");
  }
}
