import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/base/constants/constants.dart';
import 'package:wardeleven/base/text_capitalize.dart';
import 'package:wardeleven/material/views/main_container/main_container.dart';
import 'package:wardeleven/material/widgets/custom_circular_progress_indicator.dart';
import 'package:wardeleven/material/widgets/custom_date_picker.dart';
import 'package:wardeleven/material/widgets/custom_text_form_field.dart';
import 'package:wardeleven/material/widgets/form_field_dropdown.dart';
import 'package:wardeleven/material/widgets/form_row.dart';
import 'package:wardeleven/material/widgets/form_title.dart';
import 'package:wardeleven/models/action_type_model.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/models/priority_model.dart';
import 'package:wardeleven/models/surgery_type_model.dart';
import 'package:wardeleven/shared/viewmodels/create_patient_viewmodel.dart';

import '../../material_styles.dart';

class DiagnosisView extends StatefulWidget {
  final PatientModel? selectedPatient;

  const DiagnosisView({Key? key, this.selectedPatient}) : super(key: key);

  @override
  _DiagnosisViewState createState() => _DiagnosisViewState();
}

class _DiagnosisViewState extends State<DiagnosisView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _indicationController = TextEditingController();
  final TextEditingController _surgeryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var newPatient = context.read<CreatePatientViewmodel>().newPatient;
    _indicationController.text = newPatient.diagnosis.indication;
    _dateController.text = newPatient.diagnosis.diagnosisDateToString;
    _surgeryController.text =
        newPatient.diagnosis.surgery ?? Constants.emptyString;
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _indicationController.dispose();
    _surgeryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.select(
            (CreatePatientViewmodel viewmodel) => viewmodel.isPatientCreated) ==
        DataState.success) {
      Future.delayed(Duration.zero, () async {
        await _showMessage(
            context, 'Success!', 'The patient was created successfully.');
      });
    } else if (context.select(
            (CreatePatientViewmodel viewmodel) => viewmodel.isPatientUpdated) ==
        DataState.success) {
      Future.delayed(Duration.zero, () async {
        await _showMessage(
            context, 'Success!', 'The patient was updated successfully.');
      });
    } else if (context
            .select((CreatePatientViewmodel viewmodel) => viewmodel.failure) !=
        null) {
      Future.delayed(Duration.zero, () async {
        await _showMessage(
            context, 'Error!', 'An internal error occurred. Please try again.');
      });
    }

    return WillPopScope(
      onWillPop: () async {
        _dateController.text = context
            .read<CreatePatientViewmodel>()
            .newPatient
            .diagnosis
            .diagnosisDateToString;
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              widget.selectedPatient != null
                  ? 'Update patient'
                  : 'Create patient',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Styles.white),
            )),
        body: SafeArea(
            child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Styles.horizontalPadding, vertical: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      children: _initializeView() +
                          [_validateAndSubmitButton(context)]),
                ),
              ),
            ),
            CustomCircularProgressIndicator(
              isLoading: context.select(
                  (CreatePatientViewmodel viewModel) => viewModel.isLoading),
            )
          ],
        )),
      ),
    );
  }

  List<Widget> _initializeView() {
    var actionType = context.watch<CreatePatientViewmodel>().actionType;
    if (actionType == ActionType.surgery) {
      return [
        FormTitle(
          title: 'Diagnosis Information',
        ),
        _indication(context),
        _diagnosisDate(context),
        _priority(context),
        _actionType(context),
        _surgery(context),
        _surgeryType(context),
      ];
    } else if (actionType == ActionType.endoscopy) {
      return [
        FormTitle(
          title: 'Diagnosis Information',
        ),
        _indication(context),
        _diagnosisDate(context),
        _priority(context),
        _actionType(context),
        _procedure(context),
      ];
    }
    return [
      FormTitle(
        title: 'Diagnosis Information',
      ),
      _indication(context),
      _diagnosisDate(context),
      _priority(context),
      _actionType(context),
    ];
  }

  Widget _indication(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: FormRow(
            icon: Icon(Icons.assessment_outlined),
            formField: CustomTextFormField(
              label: 'Indication/diagnosis',
              controller: _indicationController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid indication/diagnosis';
                }
                return null;
              },
            )),
      );

  Widget _diagnosisDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FormRow(
        icon: Icon(Icons.event),
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
                        },
                        firstDate: DateTime(1990, 1),
                        lastDate: DateTime.now())
                    .build(context);
              });
        }),
      ),
    );
  }

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
                      .procedure ??
                  Constants.emptyString,
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

  Widget _actionType(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
            icon: Icon(Icons.dynamic_form_outlined),
            formField: FormFieldDropdown(
              label: 'Action type',
              value: context
                  .read<CreatePatientViewmodel>()
                  .newPatient
                  .diagnosis
                  .actionType
                  .string,
              listItems:
                  ActionType.values.map((e) => e.string.capitalize()).toList(),
              onChangedCallback: (String? value) {
                var patient = context.read<CreatePatientViewmodel>().newPatient;
                patient.diagnosis.actionType =
                    value?.actionType ?? ActionType.review;
                context
                    .read<CreatePatientViewmodel>()
                    .setNewPatientDetails(patient);
              },
            )),
      );

  Widget _surgery(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FormRow(
            icon: Icon(Icons.cut),
            formField: CustomTextFormField(
              label: 'Surgery',
              controller: _surgeryController,
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
                  .surgeryType
                  .string
                  .toUpperCase(),
              listItems: SurgeryType.values.map((e) => e.string).toList(),
              onChangedCallback: (value) {
                var patient = context.read<CreatePatientViewmodel>().newPatient;
                patient.diagnosis.surgeryType = value.surgeryType;
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
              listItems:
                  Priority.values.map((e) => e.string.capitalize()).toList(),
              value: context
                  .watch<CreatePatientViewmodel>()
                  .newPatient
                  .diagnosis
                  .priority
                  .string,
              onChangedCallback: (value) {
                var viewModel = context.read<CreatePatientViewmodel>();
                var patient = viewModel.newPatient;
                patient.diagnosis.priority = value!.priority;
                viewModel.setNewPatientDetails(patient);
              },
            );
          }),
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainContainer()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _validateAndSubmitButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Submit',
                style: TextStyle(
                    fontSize: Styles.fontSize21,
                    fontWeight: Styles.fontWeightSemiBold,
                    color: MaterialStyles.lightTheme.primaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var viewModel = context.read<CreatePatientViewmodel>();
                viewModel.setLoading(LoadingState.loading);
                _submitControllerData(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DiagnosisView()));
                viewModel.setLoading(LoadingState.complete);
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

  _submitControllerData(BuildContext context) async {
    var viewModel = context.read<CreatePatientViewmodel>();
    viewModel.newPatient.diagnosis.date =
        DateFormat('dd/MM/yyyy').parse(_dateController.text);
    viewModel.newPatient.diagnosis.indication = _indicationController.text;
    viewModel.newPatient.diagnosis.surgery = _surgeryController.text;
    viewModel.setNewPatientDetails(viewModel.newPatient);
    if (widget.selectedPatient != null) {
      await context.read<CreatePatientViewmodel>().updatePatient();
    } else {
      await context.read<CreatePatientViewmodel>().createPatient();
    }
  }
}
