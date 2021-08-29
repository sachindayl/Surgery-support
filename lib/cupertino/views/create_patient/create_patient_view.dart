import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/widgets/custom_alert_dialog.dart';
import 'package:wardeleven/cupertino/widgets/custom_circular_progress_indicator.dart';
import 'package:wardeleven/cupertino/widgets/custom_date_time_picker.dart';
import 'package:wardeleven/cupertino/widgets/custom_form_field_picker.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/shared/viewmodels/create_patient_viewmodel.dart';

class CreatePatientView extends StatelessWidget {
  final _genderController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dobController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.select(
            (CreatePatientViewmodel viewmodel) => viewmodel.isPatientCreated) ==
        DataState.success) {
      Future.delayed(Duration.zero, () async {
        await _displayMessage(
            context, 'Success!', 'The patient was created successfully.');
      });
    } else if (context
            .select((CreatePatientViewmodel viewmodel) => viewmodel.failure) !=
        null) {
      Future.delayed(Duration.zero, () async {
        await _displayMessage(
            context, 'Error!', 'An internal error occurred. Please try again.');
      });
    }
    return Stack(
      children: [
        CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              middle: Text('Create Patient'),
              trailing: _createPatientButton(context)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: Styles.white,
                child: Column(children: [
                  CupertinoFormSection(
                      header: Text('Personal information'.toUpperCase()),
                      backgroundColor:
                          CupertinoTheme.of(context).scaffoldBackgroundColor,
                      children: _personalInfoForm(context)),
                  CupertinoFormSection(
                    header: Text('Diagnosis information'.toUpperCase()),
                    backgroundColor:
                        CupertinoTheme.of(context).scaffoldBackgroundColor,
                    children: _diagnosisInfoForm(context),
                  ),
                ]),
              ),
            ),
          ),
        ),
        context.select((CreatePatientViewmodel viewModel) =>
            CustomCircularProgressIndicator(isLoading: viewModel.isLoading))
      ],
    );
  }

  List<Widget> _personalInfoForm(BuildContext context) => [
        CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
          placeholder: 'Registration No.',
          maxLength: 25,
          keyboardType: TextInputType.name,
          initialValue: context
              .read<CreatePatientViewmodel>()
              .newPatient
              .personalInfo
              .registrationNo,
          onChanged: (value) {
            var patient = context.read<CreatePatientViewmodel>().newPatient;
            patient.personalInfo.registrationNo = value;
            context
                .read<CreatePatientViewmodel>()
                .setNewPatientDetails(patient);
          },
        )),
        CupertinoFormRow(
            child: CustomFormFieldPicker(
          controller: _categoryController,
          placeholder: 'Category',
          pickerIndex: context.watch<CreatePatientViewmodel>().categoryIndex,
          pickerList: context.select(
              (CreatePatientViewmodel viewModel) => viewModel.categoryList),
          pickerTitle: 'Category',
          setNewIndex: (index) =>
              context.read<CreatePatientViewmodel>().setCategory(index),
        )),
        CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
          placeholder: 'First name',
          maxLength: 25,
          keyboardType: TextInputType.text,
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
        )),
        CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
          maxLength: 25,
          keyboardType: TextInputType.text,
          initialValue: context
              .read<CreatePatientViewmodel>()
              .newPatient
              .personalInfo
              .name
              .lastName,
          placeholder: 'Last name',
          onChanged: (value) {
            var patient = context.read<CreatePatientViewmodel>().newPatient;
            patient.personalInfo.name.lastName = value;
            context
                .read<CreatePatientViewmodel>()
                .setNewPatientDetails(patient);
          },
        )),
        CupertinoFormRow(child: Consumer<CreatePatientViewmodel>(
            builder: (context, viewModel, child) {
          return CupertinoTextFormFieldRow(
            onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (_) => CustomDateTimePicker(
                      isDate: true,
                      value: viewModel.newPatient.personalInfo.formattedDob,
                      maxDate: DateTime.now(),
                      minDate: DateTime(1900, 1),
                      valueCallback: (updatedDate) {
                        _dobController.text =
                            DateFormat('dd/MM/yyyy').format(updatedDate);
                        viewModel.newPatient.personalInfo.setDob(updatedDate);
                        viewModel.setNewPatientDetails(viewModel.newPatient);
                      },
                    )),
            placeholder: 'Date of birth',
            readOnly: true,
            controller: _dobController,
            style: TextStyle(color: Styles.black.withOpacity(Styles.opacity87)),
            keyboardType: TextInputType.name,
          );
        })),
        CupertinoFormRow(
            child: CustomFormFieldPicker(
          controller: _genderController,
          placeholder: 'Gender',
          pickerIndex: context.watch<CreatePatientViewmodel>().genderIndex,
          pickerList: context.select(
              (CreatePatientViewmodel viewModel) => viewModel.genderList),
          pickerTitle: 'Gender',
          setNewIndex: (index) =>
              context.read<CreatePatientViewmodel>().setGenderIndex(index),
        )),
      ];

  List<Widget> _diagnosisInfoForm(BuildContext context) => [
        CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
          placeholder: 'Indication/diagnosis',
          maxLength: 200,
          keyboardType: TextInputType.name,
        )),
        CupertinoFormRow(child: Consumer<CreatePatientViewmodel>(
            builder: (context, viewModel, child) {
          return CupertinoTextFormFieldRow(
            onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (_) => CustomDateTimePicker(
                      isDate: true,
                      value:
                          viewModel.newPatient.diagnosis.formattedDiagnosisDate,
                      maxDate: DateTime.now(),
                      minDate: DateTime(1990, 1),
                      valueCallback: (updatedDate) {
                        _dateController.text =
                            DateFormat('dd/MM/yyyy').format(updatedDate);
                        viewModel.newPatient.diagnosis
                            .setDiagnosisDate(updatedDate);
                        viewModel.setNewPatientDetails(viewModel.newPatient);
                      },
                    )),
            placeholder: 'Date',
            readOnly: true,
            controller: _dateController,
            style: TextStyle(color: Styles.black.withOpacity(Styles.opacity87)),
            keyboardType: TextInputType.name,
          );
        })),
        CupertinoFormRow(
            child: CustomFormFieldPicker(
          controller: _genderController,
          placeholder: 'Procedure',
          pickerIndex: context.watch<CreatePatientViewmodel>().genderIndex,
          pickerList: context.select(
              (CreatePatientViewmodel viewModel) => viewModel.genderList),
          pickerTitle: 'Procedure',
          setNewIndex: (index) =>
              context.read<CreatePatientViewmodel>().setGenderIndex(index),
        )),
        CupertinoFormRow(child: Consumer<CreatePatientViewmodel>(
            builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () {
              viewModel.newPatient.diagnosis.isOutside =
                  !viewModel.newPatient.diagnosis.isOutside;
              return viewModel.setNewPatientDetails(viewModel.newPatient);
            },
            child: Container(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: Text('Outside'),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 4.0),
                    child: CupertinoSwitch(
                      value: viewModel.newPatient.diagnosis.isOutside,
                      onChanged: (_) {},
                    ),
                  )
                ],
              ),
            ),
          );
        })),
        CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
          placeholder: 'Surgery',
          maxLength: 200,
          keyboardType: TextInputType.name,
        )),
        CupertinoFormRow(
            child: CustomFormFieldPicker(
          controller: _genderController,
          placeholder: 'Surgery type',
          pickerIndex: context.watch<CreatePatientViewmodel>().genderIndex,
          pickerList: context.select(
              (CreatePatientViewmodel viewModel) => viewModel.genderList),
          pickerTitle: 'Surgery type',
          setNewIndex: (index) =>
              context.read<CreatePatientViewmodel>().setGenderIndex(index),
        )),
        CupertinoFormRow(
            child: CustomFormFieldPicker(
          controller: _genderController,
          placeholder: 'Priority',
          pickerIndex: context.watch<CreatePatientViewmodel>().genderIndex,
          pickerList: context.select(
              (CreatePatientViewmodel viewModel) => viewModel.genderList),
          pickerTitle: 'Priority',
          setNewIndex: (index) =>
              context.read<CreatePatientViewmodel>().setGenderIndex(index),
        ))
      ];

  Widget _createPatientButton(BuildContext context) => GestureDetector(
        onTap: () => Future.delayed(Duration.zero, () async {
          context
              .read<CreatePatientViewmodel>()
              .setLoading(LoadingState.loading);
          await context.read<CreatePatientViewmodel>().createPatient();
          context
              .read<CreatePatientViewmodel>()
              .setLoading(LoadingState.complete);
        }),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Create'),
        ),
      );

  _displayMessage(BuildContext context, String title, String content) async {
    await showCupertinoDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
              title: 'Success!',
              content: 'The patient was created successfully.',
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    context.read<CreatePatientViewmodel>().clearPatientData();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
