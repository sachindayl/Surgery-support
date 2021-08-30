
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/widgets/form_title.dart';
import 'package:wardeleven/material/widgets/custom_date_picker.dart';
import 'package:wardeleven/material/widgets/custom_text_form_field.dart';
import 'package:wardeleven/material/widgets/form_field_dropdown.dart';
import 'package:wardeleven/material/widgets/form_row.dart';
import 'package:wardeleven/models/gender_model.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/shared/viewmodels/create_patient_viewmodel.dart';

import '../../material_styles.dart';
import 'diagnosis_view.dart';

class PersonalInfoView extends StatefulWidget {
  final PatientModel? selectedPatient;

  PersonalInfoView({this.selectedPatient});

  @override
  _PersonalInfoViewState createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final TextEditingController _regController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<CreatePatientViewmodel>().setNewPatientDetails(
          widget.selectedPatient ?? PatientModel.newInstance());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _regController.dispose();
    _dobController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<CreatePatientViewmodel>().clearPatientData();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.selectedPatient != null
              ? 'Update patient'
              : 'Create patient'),
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
      ),
    );
  }

  Widget _registrationNumber(BuildContext context) {
    _regController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .registrationNo;
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: FormRow(
        icon: Icon(Icons.app_registration),
        formField: CustomTextFormField(
          controller: _regController,
          label: 'Registration No',
        ),
      ),
    );
  }

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

  Widget _firstName(BuildContext context) {
    _firstNameController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .name
        .firstName;
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
          icon: Icon(Icons.person),
          formField: CustomTextFormField(
            label: 'First name',
            controller: _firstNameController,
          ),
        ));
  }

  Widget _lastName(BuildContext context) {
    _lastNameController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .name
        .lastName;
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
          formField: CustomTextFormField(
            label: 'Last name',
            controller: _lastNameController,
          ),
        ));
  }

  Widget _gender(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Row(
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
                        onTap: () {
                          viewModel.newPatient.personalInfo.gender =
                              Gender.male.string;
                          viewModel.setNewPatientDetails(viewModel.newPatient);
                        },
                        trailing: Radio<Gender>(
                          value: Gender.male,
                          groupValue:
                              viewModel.newPatient.personalInfo.gender.gender,
                          onChanged: (_) {},
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
                        onTap: () {
                          viewModel.newPatient.personalInfo.gender =
                              Gender.female.string;
                          viewModel.setNewPatientDetails(viewModel.newPatient);
                        },
                        trailing: Radio<Gender>(
                          value: Gender.female,
                          groupValue:
                              viewModel.newPatient.personalInfo.gender.gender,
                          onChanged: (_) => {},
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MaterialStyles.iconSizedBoxWidth,
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: Styles.black.withOpacity(Styles.opacity51))),
                    child: Consumer<CreatePatientViewmodel>(
                        builder: (context, viewModel, child) {
                      return ListTile(
                        title: Text('Other'),
                        onTap: () {
                          viewModel.newPatient.personalInfo.gender =
                              Gender.other.string;
                          viewModel.setNewPatientDetails(viewModel.newPatient);
                        },
                        trailing: Radio<Gender>(
                          value: Gender.other,
                          groupValue:
                              viewModel.newPatient.personalInfo.gender.gender,
                          onChanged: (_) => {},
                        ),
                      );
                    }),
                  ),
                ),
              ],
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

  _savePersonalInfo(BuildContext context) {
    var viewModel = context.read<CreatePatientViewmodel>();
    viewModel.newPatient.personalInfo.registrationNo = _regController.text;
    viewModel.newPatient.personalInfo.name.firstName =
        _firstNameController.text;
    viewModel.newPatient.personalInfo.name.lastName = _lastNameController.text;
    viewModel.setNewPatientDetails(viewModel.newPatient);
  }
}
