import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/patient_profile/patient_profile_view.dart';
import 'package:wardeleven/material/widgets/custom_card.dart';

class PatientListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        horizontalTitleGap: 2,
        title: Text('John Smith'),
        subtitle: Text('No.734243244'),
        leading: SizedBox(
            height: 50.0,
            child: Icon(
              Icons.circle,
              size: Styles.fontSize14,
            )),
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PatientProfileView())),
      ),
    );
  }
}
