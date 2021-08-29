import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/cupertino_styles.dart';
import 'package:wardeleven/cupertino/views/patient_profile/patient_profile_view.dart';
import 'package:wardeleven/models/patient_model.dart';

class PatientListItem extends StatelessWidget {
  final PatientModel patient;


  PatientListItem({required this.patient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context)
              .push(
              CupertinoPageRoute(builder: (context) => PatientProfileView())),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Styles.white,
            borderRadius: BorderRadius.circular(Styles.itemBorderRadius)),
        child: Row(
          children: [
            SizedBox(
                height: 40.0,
                width: 40.0,
                child: Icon(
                  CupertinoIcons.circle_filled,
                  size: Styles.fontSize14,
                  color: statusColor,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      patient.fullName,
                      style: CupertinoStyles.cardTitleText,
                    ),
                  ),
                  Text(
                    patient.personalInfo.registrationNo,
                    style: CupertinoStyles.cardSubTitleText,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get statusColor {
    if (patient.diagnosis.priority.toLowerCase() == "high") {
      return CupertinoColors.destructiveRed;
    } else if (patient.diagnosis.priority.toLowerCase() == "medium") {
      return CupertinoColors.activeOrange;
    } else {
      return CupertinoColors.activeGreen;
    }
  }
}
