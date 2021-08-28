import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/cupertino_styles.dart';
import 'package:wardeleven/cupertino/views/patient_profile/patient_profile_view.dart';

class PatientListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => PatientProfileView())),
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
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'John Smith',
                      style: CupertinoStyles.cardTitleText,
                    ),
                  ),
                  Text(
                    'No.132434324',
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
}
