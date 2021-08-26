import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:surgery_support/base/base_styles.dart';
import 'package:surgery_support/cupertino/views/create_patient/diagnosis_view.dart';

class PersonalInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Create Patient'),
        trailing: GestureDetector(
          onTap: () => showCupertinoModalBottomSheet(
              context: context, builder: (context) => DiagnosisView()),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Next'),
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          color: Styles.white,
          child: Column(
            children: [
              CupertinoFormSection(
                header: Text('Personal information'.toUpperCase()),
                  backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
                  children: <Widget>[
                    CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          placeholder: 'Registration No.',
                          maxLength: 25,
                          keyboardType: TextInputType.name,
                        )),
                    CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          placeholder: 'description',
                          maxLength: 100,
                          keyboardType: TextInputType.text,
                        )),
                    CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          initialValue: '',
                          placeholder: 'category',
                          readOnly: true,
                        )),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
