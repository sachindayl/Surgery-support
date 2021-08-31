import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/cupertino/widgets/custom_alert_dialog.dart';
import 'package:wardeleven/cupertino/widgets/custom_circular_progress_indicator.dart';
import 'package:wardeleven/cupertino/widgets/custom_date_time_picker.dart';
import 'package:wardeleven/cupertino/widgets/custom_form_field_picker.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/shared/viewmodels/create_patient_viewmodel.dart';
import 'package:wardeleven/base/text_capitalize.dart';

class CreatePatientView extends StatefulWidget {
  final PatientModel? selectedPatient;
  final Function(bool) updateSuccessful;

  CreatePatientView({this.selectedPatient, required this.updateSuccessful});

  @override
  _CreatePatientViewState createState() => _CreatePatientViewState();
}

class _CreatePatientViewState extends State<CreatePatientView> {
  final _regController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dobController = TextEditingController();
  final _dateController = TextEditingController();
  final _priorityController = TextEditingController();
  final _indicationController = TextEditingController();
  final _procedureController = TextEditingController();
  final _surgeryController = TextEditingController();
  final _surgeryTypeController = TextEditingController();

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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _phoneNumberController.dispose();
    _categoryController.dispose();
    _dobController.dispose();
    _dateController.dispose();
    _priorityController.dispose();
    _indicationController.dispose();
    _procedureController.dispose();
    _surgeryController.dispose();
    _surgeryTypeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.select(
            (CreatePatientViewmodel viewmodel) => viewmodel.isPatientCreated) ==
        DataState.success) {
      Future.delayed(Duration.zero, () async {
        await _displayMessage(
            context, 'Success!', 'The patient was created successfully.');
      });
    } else if (context.select(
            (CreatePatientViewmodel viewmodel) => viewmodel.isPatientUpdated) ==
        DataState.success) {
      Future.delayed(Duration.zero, () async {
        await _displayMessage(
            context, 'Success!', 'The patient was updated successfully.');
      });
    } else if (context
            .select((CreatePatientViewmodel viewmodel) => viewmodel.failure) !=
        null) {
      Future.delayed(Duration.zero, () async {
        await _displayMessage(
            context, 'Error!', 'An internal error occurred. Please try again.');
      });
    }
    return WillPopScope(
      onWillPop: () {
        context.read<CreatePatientViewmodel>().clearPatientData();
        return Future.value(true);
      },
      child: Stack(
        children: [
          CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                middle: Text(widget.selectedPatient != null
                    ? 'Update patient'
                    : 'Create Patient'),
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
      ),
    );
  }

  List<Widget> _personalInfoForm(BuildContext context) => [
        _registrationNumber(context),
        _category(context),
        _firstName(context),
        _lastName(context),
        _dateOfBirth(context),
        _gender(context),
        _phoneNumber(context)
      ];

  List<Widget> _diagnosisInfoForm(BuildContext context) => [
        _indication(context),
        _diagnosisDate(context),
        _procedure(context),
        _isOutside(context),
        _surgery(context),
        _surgeryType(context),
        _priority(context)
      ];

  Widget _createPatientButton(BuildContext context) => GestureDetector(
        onTap: () => Future.delayed(Duration.zero, () async {
          context
              .read<CreatePatientViewmodel>()
              .setLoading(LoadingState.loading);
          _savePersonalInfo(context);
          widget.selectedPatient != null
              ? await context.read<CreatePatientViewmodel>().updatePatient()
              : await context.read<CreatePatientViewmodel>().createPatient();
          context
              .read<CreatePatientViewmodel>()
              .setLoading(LoadingState.complete);
        }),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(widget.selectedPatient != null ? 'Update' : 'Create', style: TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor, fontWeight: Styles.fontWeightSemiBold),),
        ),
      );

  _displayMessage(BuildContext context, String title, String content) async {
    await showCupertinoDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
              title: title,
              content: content,
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    context.read<CreatePatientViewmodel>().clearPatientData();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    widget.updateSuccessful(true);
                  },
                )
              ],
            ));
  }

  //region personal info

  Widget _registrationNumber(BuildContext context) {
    _regController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .registrationNo;
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      placeholder: 'Registration No.',
      maxLength: 25,
      keyboardType: TextInputType.name,
      controller: _regController,
    ));
  }

  Widget _category(BuildContext context) {
    _categoryController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .category;
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _categoryController,
      placeholder: 'Category',
      pickerIndex: context.watch<CreatePatientViewmodel>().categoryIndex,
      pickerList: context
          .select((CreatePatientViewmodel viewModel) => viewModel.categoryList),
      pickerTitle: 'Category',
      setNewIndex: (index) =>
          context.read<CreatePatientViewmodel>().setCategory(index),
    ));
  }

  Widget _firstName(BuildContext context) {
    _firstNameController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .name
        .firstName;
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      placeholder: 'First name',
      maxLength: 25,
      keyboardType: TextInputType.text,
      controller: _firstNameController,
    ));
  }

  Widget _lastName(BuildContext context) {
    _lastNameController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .name
        .lastName;
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
            maxLength: 30,
            keyboardType: TextInputType.text,
            controller: _lastNameController,
            placeholder: 'Last name'));
  }

  Widget _dateOfBirth(BuildContext context) {
    _dobController.text =
        context.read<CreatePatientViewmodel>().newPatient.personalInfo.dob;
    return CupertinoFormRow(child:
        Consumer<CreatePatientViewmodel>(builder: (context, viewModel, child) {
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
    }));
  }

  Widget _gender(BuildContext context) {
    _genderController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .gender
        .capitalize();
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _genderController,
      placeholder: 'Gender',
      pickerIndex: context.watch<CreatePatientViewmodel>().genderIndex,
      pickerList: context
          .select((CreatePatientViewmodel viewModel) => viewModel.genderList),
      pickerTitle: 'Gender',
      setNewIndex: (index) =>
          context.watch<CreatePatientViewmodel>().setGenderIndex(index),
    ));
  }

  Widget _phoneNumber(BuildContext context) {
    _phoneNumberController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .phoneNumber;
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
            maxLength: 13,
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            placeholder: 'Phone number'));
  }

// endregion

// region diagnosis
  Widget _indication(BuildContext context) {
    _indicationController.text =
        context.watch<CreatePatientViewmodel>().newPatient.diagnosis.indication;
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      controller: _indicationController,
      placeholder: 'Indication/diagnosis',
      maxLength: 200,
      keyboardType: TextInputType.name,
    ));
  }

  Widget _diagnosisDate(BuildContext context) {
    _dateController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .diagnosis
        .diagnosisDateToString;
    return CupertinoFormRow(child:
        Consumer<CreatePatientViewmodel>(builder: (context, viewModel, child) {
      return CupertinoTextFormFieldRow(
        onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (_) => CustomDateTimePicker(
                  isDate: true,
                  value: viewModel.newPatient.diagnosis.date,
                  maxDate: DateTime.now(),
                  minDate: DateTime(1990, 1),
                  valueCallback: (updatedDate) {
                    _dateController.text =
                        DateFormat('dd/MM/yyyy').format(updatedDate);
                    viewModel.newPatient.diagnosis.date = updatedDate;
                    viewModel.setNewPatientDetails(viewModel.newPatient);
                  },
                )),
        placeholder: 'Date',
        readOnly: true,
        controller: _dateController,
        style: TextStyle(color: Styles.black.withOpacity(Styles.opacity87)),
        keyboardType: TextInputType.name,
      );
    }));
  }

  Widget _procedure(BuildContext context) {
    _procedureController.text =
        context.watch<CreatePatientViewmodel>().newPatient.diagnosis.procedure;
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _procedureController,
      placeholder: 'Procedure',
      pickerIndex: context.watch<CreatePatientViewmodel>().procedureIndex,
      pickerList: context.select(
          (CreatePatientViewmodel viewModel) => viewModel.procedureList),
      pickerTitle: 'Procedure',
      setNewIndex: (index) =>
          context.watch<CreatePatientViewmodel>().setProcedureIndex(index),
    ));
  }

  Widget _isOutside(BuildContext context) {
    return CupertinoFormRow(child:
        Consumer<CreatePatientViewmodel>(builder: (context, viewModel, child) {
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
    }));
  }

  Widget _surgery(BuildContext context) {
    _surgeryController.text =
        context.watch<CreatePatientViewmodel>().newPatient.diagnosis.surgery;
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      controller: _surgeryController,
      placeholder: 'Surgery',
      maxLength: 200,
      keyboardType: TextInputType.name,
    ));
  }

  Widget _surgeryType(BuildContext context) {
    _surgeryTypeController.text = context
        .watch<CreatePatientViewmodel>()
        .newPatient
        .diagnosis
        .surgeryType;
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _surgeryTypeController,
      placeholder: 'Surgery type',
      pickerIndex: context.watch<CreatePatientViewmodel>().surgeryTypeIndex,
      pickerList: context.select(
          (CreatePatientViewmodel viewModel) => viewModel.surgeryTypeList),
      pickerTitle: 'Surgery type',
      setNewIndex: (index) =>
          context.watch<CreatePatientViewmodel>().setSurgeryTypeIndex(index),
    ));
  }

  Widget _priority(BuildContext context) {
    _priorityController.text =
        context.watch<CreatePatientViewmodel>().newPatient.diagnosis.priority;
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _priorityController,
      placeholder: 'Priority',
      pickerIndex: context.watch<CreatePatientViewmodel>().priorityIndex,
      pickerList: context
          .select((CreatePatientViewmodel viewModel) => viewModel.priorityList),
      pickerTitle: 'Priority',
      setNewIndex: (index) =>
          context.watch<CreatePatientViewmodel>().setPriorityIndex(index),
    ));
  }

// endregion

  _savePersonalInfo(BuildContext context) {
    var viewModel = context.read<CreatePatientViewmodel>();
    viewModel.newPatient.personalInfo.registrationNo = _regController.text;
    viewModel.newPatient.personalInfo.name.firstName =
        _firstNameController.text;
    viewModel.newPatient.personalInfo.name.lastName = _lastNameController.text;
    viewModel.newPatient.personalInfo.phoneNumber = _phoneNumberController.text;
    viewModel.newPatient.diagnosis.indication = _indicationController.text;
    viewModel.newPatient.diagnosis.surgery = _surgeryController.text;
    viewModel.newPatient.diagnosis.procedure = _procedureController.text;
    viewModel.newPatient.diagnosis.priority = _priorityController.text;
    viewModel.newPatient.diagnosis.surgeryType = _surgeryTypeController.text;
    viewModel.setNewPatientDetails(viewModel.newPatient);
  }
}
