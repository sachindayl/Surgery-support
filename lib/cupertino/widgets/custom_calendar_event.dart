import 'package:flutter/cupertino.dart';
import 'package:wardeleven/cupertino/views/patient_profile/patient_profile_view.dart';

class CustomCalendarEvent extends StatelessWidget {

  CustomCalendarEvent();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => PatientProfileView())),
        child: Container(
          child: Text('event'),
        ),
      );
}
