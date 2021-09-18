import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/create_patient/personal_info_view.dart';
import 'package:wardeleven/material/widgets/custom_card.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/models/priority_model.dart';

class PatientListItem extends StatelessWidget {
  final PatientModel patient;

  PatientListItem({required this.patient});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        horizontalTitleGap: 2,
        title: Text(patient.fullName),
        subtitle: Text(patient.personalInfo.registrationNo),
        leading: SizedBox(
            height: 40.0,
            width: 40.0,
            child: Icon(
              Icons.circle,
              size: Styles.fontSize14,
              color: statusColor,
            )),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PersonalInfoView(selectedPatient: patient))),
      ),
    );
  }

  Color get statusColor {
    switch (patient.diagnosis.priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orangeAccent;
      case Priority.high:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
