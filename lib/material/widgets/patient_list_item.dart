import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/create_patient/personal_info_view.dart';
import 'package:wardeleven/material/widgets/custom_card.dart';
import 'package:wardeleven/models/patient_model.dart';

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
    if (patient.diagnosis.priority.toLowerCase() == "high") {
      return Colors.red;
    } else if (patient.diagnosis.priority.toLowerCase() == "medium") {
      return Colors.orangeAccent;
    } else if (patient.diagnosis.priority.toLowerCase() == "low") {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
