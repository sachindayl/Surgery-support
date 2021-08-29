import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/widgets/form_title.dart';
import 'package:wardeleven/material/widgets/custom_date_picker.dart';
import 'package:wardeleven/material/widgets/custom_text_form_field.dart';
import 'package:wardeleven/material/widgets/form_field_dropdown.dart';
import 'package:wardeleven/material/widgets/form_row.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/shared/viewmodels/create_patient_viewmodel.dart';

import '../../material_styles.dart';
import 'diagnosis_view.dart';

class PersonalInfoView extends StatelessWidget {
  final TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create patient'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Styles.horizontalPadding),
            child: Column(
              children: [
                FormTitle(
                  title: 'Personal Information',
                ),
                _registrationNumber(context),
                _category(context),
                _firstName(context),
                _lastName(context),
                _gender(context),
                _dob(context),
                _telephoneNumber(context),
                _continueButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registrationNumber(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: FormRow(
          icon: Icon(Icons.app_registration),
          formField: CustomTextFormField(
            initialValue: context
                .read<CreatePatientViewmodel>()
                .newPatient
                .personalInfo
                .registrationNo,
            label: 'Registration No',
            onChanged: (value) {
              var patient = context.read<CreatePatientViewmodel>().newPatient;
              patient.personalInfo.registrationNo = value;
              context
                  .read<CreatePatientViewmodel>()
                  .setNewPatientDetails(patient);
            },
          ),
        ),
      );

  Widget _category(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Consumer<CreatePatientViewmodel>(
            builder: (context, viewModel, child) {
          return FormRow(
              formField: FormFieldDropdown(
            label: 'Category',
            listItems: viewModel.categoryList,
            value: context
                .watch<CreatePatientViewmodel>()
                .newPatient
                .personalInfo
                .category,
            onChangedCallback: (value) {
              var patient = context.read<CreatePatientViewmodel>().newPatient;
              patient.personalInfo.category = value;
              context
                  .read<CreatePatientViewmodel>()
                  .setNewPatientDetails(patient);
            },
          ));
        }),
      );

  Widget _firstName(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FormRow(
        icon: Icon(Icons.person),
        formField: CustomTextFormField(
          label: 'First name',
          initialValue: context
              .read<CreatePatientViewmodel>()
              .newPatient
              .personalInfo
              .name
              .firstName,
          onChanged: (value) {
            var patient = context.read<CreatePatientViewmodel>().newPatient;
            patient.personalInfo.name.firstName = value;
            context
                .read<CreatePatientViewmodel>()
                .setNewPatientDetails(patient);
          },
        ),
      ));

  Widget _lastName(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FormRow(
        formField: CustomTextFormField(
          label: 'Last name',
          initialValue: context
              .read<CreatePatientViewmodel>()
              .newPatient
              .personalInfo
              .name
              .lastName,
          onChanged: (value) {
            var patient = context.read<CreatePatientViewmodel>().newPatient;
            patient.personalInfo.name.lastName = value;
            context
                .read<CreatePatientViewmodel>()
                .setNewPatientDetails(patient);
          },
        ),
      ));

  Widget _gender(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: MaterialStyles.iconSizedBoxWidth,
              child: Icon(Icons.female),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(right: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        color: Styles.black.withOpacity(Styles.opacity51))),
                child: Consumer<CreatePatientViewmodel>(
                    builder: (context, viewModel, child) {
                  return ListTile(
                    title: Text('Male'),
                    onTap: () => viewModel.setGender(Gender.male),
                    trailing: Radio<Gender>(
                      value: Gender.male,
                      groupValue: viewModel.gender,
                      onChanged: (_) => {},
                    ),
                  );
                }),
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(left: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        color: Styles.black.withOpacity(Styles.opacity51))),
                child: Consumer<CreatePatientViewmodel>(
                    builder: (context, viewModel, child) {
                  return ListTile(
                    title: Text('Female'),
                    onTap: () => viewModel.setGender(Gender.female),
                    trailing: Radio<Gender>(
                      value: Gender.female,
                      groupValue: viewModel.gender,
                      onChanged: (_) => {},
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      );

  Widget _dob(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FormRow(
        icon: Icon(Icons.cake),
        formField: Consumer<CreatePatientViewmodel>(
            builder: (context, viewModel, child) {
          return TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date of birth',
              ),
              readOnly: true,
              onTap: () async => await CustomDatePicker(
                      selectedDate:
                          viewModel.newPatient.personalInfo.formattedDob,
                      newDateCallback: (newDate) {
                        var inputFormat = DateFormat('dd/MM/yyyy');
                        _dobController.text = inputFormat.format(newDate);
                        viewModel.newPatient.personalInfo.setDob(newDate);
                        viewModel.setNewPatientDetails(viewModel.newPatient);
                      },
                      firstDate: DateTime(1900, 1),
                      lastDate: DateTime.now())
                  .build(context));
        }),
      ));

  Widget _telephoneNumber(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FormRow(
        icon: Icon(Icons.phone),
        formField: CustomTextFormField(
          label: 'Telephone no.',
          initialValue: context
              .read<CreatePatientViewmodel>()
              .newPatient
              .personalInfo
              .phoneNumber,
          onChanged: (value) {
            var patient = context.read<CreatePatientViewmodel>().newPatient;
            patient.personalInfo.phoneNumber = value;
            context
                .read<CreatePatientViewmodel>()
                .setNewPatientDetails(patient);
          },
        ),
      ));

  Widget _continueButton(BuildContext context) => Padding(
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
                  MaterialPageRoute(builder: (context) => DiagnosisView())),
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
      );
}
