import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/material/views/main_container/main_container.dart';
import 'package:wardeleven/material/widgets/custom_circular_progress_indicator.dart';
import 'package:wardeleven/material/widgets/custom_date_picker.dart';
import 'package:wardeleven/material/widgets/custom_text_form_field.dart';
import 'package:wardeleven/material/widgets/form_field_dropdown.dart';
import 'package:wardeleven/material/widgets/form_row.dart';
import 'package:wardeleven/material/widgets/form_title.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/shared/viewmodels/create_patient_viewmodel.dart';

import '../../material_styles.dart';

class DiagnosisView extends StatelessWidget {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.select(
            (CreatePatientViewmodel viewmodel) => viewmodel.isPatientCreated) ==
        DataState.success) {
      Future.delayed(Duration.zero, () async {
        await _showMessage(
            context, 'Success!', 'The patient was created successfully.');
      });
    } else if (context
            .select((CreatePatientViewmodel viewmodel) => viewmodel.failure) !=
        null) {
      Future.delayed(Duration.zero, () async {
        await _showMessage(
            context, 'Error!', 'An internal error occurred. Please try again.');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create patient'),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Styles.horizontalPadding, vertical: 8.0),
              child: Column(
                children: [
                  FormTitle(title: 'Diagnosis information'),
                  _indication(context),
                  _surgeryDate(context),
                  _procedure(context),
                  _outsideSurgery(context),
                  _surgery(context),
                  _surgeryType(context),
                  _priority(context),
                  _createButton(context)
                ],
              ),
            ),
          ),
          CustomCircularProgressIndicator(
            isLoading: context.select(
                (CreatePatientViewmodel viewModel) => viewModel.isLoading),
          )
        ],
      )),
    );
  }

  Widget _indication(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: FormRow(
            icon: Icon(Icons.assessment_outlined),
            formField: CustomTextFormField(
              label: 'Indication/diagnosis',
              initialValue: context
                  .read<CreatePatientViewmodel>()
                  .newPatient
                  .diagnosis
                  .indication,
              onChanged: (value) {
                var patient = context.read<CreatePatientViewmodel>().newPatient;
                patient.diagnosis.indication = value;
                context
                    .read<CreatePatientViewmodel>()
                    .setNewPatientDetails(patient);
              },
            )),
      );

  Widget _surgeryDate(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
          formField: Consumer<CreatePatientViewmodel>(
              builder: (context, viewModel, child) {
            return TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date',
                ),
                readOnly: true,
                onTap: () async {
                  var inputFormat = DateFormat('dd/MM/yyyy');
                  await CustomDatePicker(
                          selectedDate: viewModel.newPatient.diagnosis.date,
                          newDateCallback: (newDate) {
                            _dateController.text = inputFormat.format(newDate);
                            viewModel.newPatient.diagnosis.date = newDate;
                            viewModel
                                .setNewPatientDetails(viewModel.newPatient);
                          },
                          firstDate: DateTime(1990, 1),
                          lastDate: DateTime.now())
                      .build(context);
                });
          }),
        ),
      );

  Widget _procedure(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
          formField: Consumer<CreatePatientViewmodel>(
              builder: (context, viewModel, child) {
            return FormFieldDropdown(
              label: 'Procedure',
              listItems: viewModel.procedureList,
              value: context
                  .read<CreatePatientViewmodel>()
                  .newPatient
                  .diagnosis
                  .procedure,
              onChangedCallback: (value) {
                var patient = context.read<CreatePatientViewmodel>().newPatient;
                patient.diagnosis.procedure = value;
                context
                    .read<CreatePatientViewmodel>()
                    .setNewPatientDetails(patient);
              },
            );
          }),
        ),
      );

  Widget _outsideSurgery(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: MaterialStyles.iconSizedBoxWidth,
              child: Icon(Icons.outbond_outlined),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        color: Styles.black.withOpacity(Styles.opacity51))),
                child: ListTile(
                  title: Text(
                    'Outside',
                    style: TextStyle(
                        color: Styles.black.withOpacity(Styles.opacity64)),
                  ),
                  trailing: Checkbox(
                      value: context
                          .watch<CreatePatientViewmodel>()
                          .newPatient
                          .diagnosis
                          .isOutside,
                      onChanged: (value) {
                        var patient =
                            context.read<CreatePatientViewmodel>().newPatient;
                        patient.diagnosis.isOutside = value ?? false;
                        context
                            .read<CreatePatientViewmodel>()
                            .setNewPatientDetails(patient);
                      }),
                ),
              ),
            )
          ],
        ),
      );

  Widget _surgery(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
            icon: Icon(Icons.cut),
            formField: CustomTextFormField(
              label: 'Surgery',
              initialValue: context
                  .read<CreatePatientViewmodel>()
                  .newPatient
                  .diagnosis
                  .surgery,
              onChanged: (value) {
                var patient = context.read<CreatePatientViewmodel>().newPatient;
                patient.diagnosis.surgery = value;
                context
                    .read<CreatePatientViewmodel>()
                    .setNewPatientDetails(patient);
              },
            )),
      );

  Widget _surgeryType(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
          formField: Consumer<CreatePatientViewmodel>(
              builder: (context, viewModel, child) {
            return FormFieldDropdown(
              label: 'Surgery type',
              value: context
                  .read<CreatePatientViewmodel>()
                  .newPatient
                  .diagnosis
                  .surgeryType,
              listItems: viewModel.surgeryTypeList,
              onChangedCallback: (value) {
                var patient = context.read<CreatePatientViewmodel>().newPatient;
                patient.diagnosis.surgeryType = value;
                context
                    .read<CreatePatientViewmodel>()
                    .setNewPatientDetails(patient);
              },
            );
          }),
        ),
      );

  Widget _priority(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
          icon: Icon(Icons.priority_high),
          formField: Consumer<CreatePatientViewmodel>(
              builder: (context, viewModel, child) {
            return FormFieldDropdown(
              label: 'Priority',
              listItems: viewModel.priorityList,
              value: context
                  .watch<CreatePatientViewmodel>()
                  .newPatient
                  .diagnosis
                  .priority,
              onChangedCallback: (value) {
                var viewModel = context.read<CreatePatientViewmodel>();
                var patient = viewModel.newPatient;
                patient.diagnosis.priority = value;
                viewModel.setNewPatientDetails(patient);
              },
            );
          }),
        ),
      );

  Widget _createButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Create',
                style: TextStyle(
                    fontSize: Styles.fontSize21,
                    fontWeight: Styles.fontWeightSemiBold,
                    color: MaterialStyles.lightTheme.primaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Future.delayed(Duration.zero, () async {
                  context
                      .read<CreatePatientViewmodel>()
                      .setLoading(LoadingState.loading);
                  await context.read<CreatePatientViewmodel>().createPatient();
                  context
                      .read<CreatePatientViewmodel>()
                      .setLoading(LoadingState.complete);
                });
              },
              child: Icon(
                Icons.save,
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

  Future<void> _showMessage(
      BuildContext context, String title, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.read<CreatePatientViewmodel>().clearPatientData();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainContainer()));
              },
            ),
          ],
        );
      },
    );
  }
}
