import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Text('app_name'.tr()),
      ),
    ));
  }
}