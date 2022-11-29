import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/base/text_capitalize.dart';
import 'package:wardeleven/cupertino/cupertino_styles.dart';
import 'package:wardeleven/cupertino/views/create_patient/create_patient_view.dart';
import 'package:wardeleven/models/action_type_model.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/models/priority_model.dart';

class PatientListItem extends StatelessWidget {
  final Function(bool) isUpdateSuccessful;
  final PatientModel patient;

  PatientListItem({required this.patient, required this.isUpdateSuccessful});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCupertinoModalBottomSheet(
          useRootNavigator: true,
          elevation: 5.0,
          expand: true,
          context: context,
          builder: (context) => CreatePatientView(
                selectedPatient: patient,
                updateSuccessful: isUpdateSuccessful,
              )),
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
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        patient.fullName,
                        style: CupertinoStyles.cardTitleText
                            .copyWith(fontSize: Styles.fontSize16),
                      ),
                    ),
                    Text(
                      patient.personalInfo.registrationNo,
                      style: CupertinoStyles.cardSubTitleText
                          .copyWith(fontSize: Styles.fontSize14),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6.0)),
              child: Text(
                patient.diagnosis.actionType.string.toLowerCase().capitalize(),
                style: TextStyle(
                    fontSize: Styles.fontSize14,
                    fontWeight: Styles.fontWeightLight,
                    color: Styles.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color get statusColor {
    switch (patient.diagnosis.priority) {
      case Priority.low:
        return CupertinoColors.activeGreen;
      case Priority.medium:
        return CupertinoColors.activeOrange;
      case Priority.high:
        return CupertinoColors.destructiveRed;
      default:
        return CupertinoColors.inactiveGray;
    }
  }
}
