import 'package:flutter/material.dart';
import 'package:surgery_support/base/base_styles.dart';
import 'package:surgery_support/material/views/create_patient/diagnosis_view.dart';
import 'package:surgery_support/material/widgets/custom_text_form_field.dart';
import 'package:surgery_support/material/widgets/form_field_dropdown.dart';
import 'package:surgery_support/material/widgets/form_row.dart';
import 'package:surgery_support/material/widgets/form_title.dart';

import '../../material_styles.dart';

class PersonalInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create patient'),
      ),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: Styles.horizontalPadding),
          child: Column(
            children: [
              FormTitle(
                title: 'Personal Information',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: FormRow(
                  icon: Icon(Icons.app_registration),
                  formField: CustomTextFormField(
                    label: 'Registration No',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(formField: FormFieldDropdown(label: 'Category')),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FormRow(
                    icon: Icon(Icons.person),
                    formField: CustomTextFormField(
                      label: 'First name',
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FormRow(
                    formField: CustomTextFormField(
                      label: 'Last name',
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(
                  icon: Icon(Icons.female),
                  formField: FormFieldDropdown(label: 'Sex'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FormRow(
                    icon: Icon(Icons.cake),
                    formField: CustomTextFormField(
                      label: 'Age',
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(
                  icon: Icon(Icons.phone),
                  formField: CustomTextFormField(
                    label: 'Telephone no.',
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontSize: Styles.fontSize21,
                            fontWeight: Styles.fontWeightSemiBold,
                            color: MaterialStyles.lightTheme.primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DiagnosisView())),
                      child: Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Styles.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Styles.accentColor,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16.0)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
