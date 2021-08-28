import 'package:flutter/cupertino.dart';

class PatientProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Text('PatientProfileView'),
      ),
    ));
  }
}
