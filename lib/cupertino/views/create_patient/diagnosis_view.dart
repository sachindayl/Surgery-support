import 'package:flutter/cupertino.dart';

class DiagnosisView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Create patient"),
          trailing: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Create"),
            ),
          ),
        ),
        child: SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Text('Diagnosis'),
      ),
    ));
  }
}