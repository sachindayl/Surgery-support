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
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dobController = TextEditingController();
  final _dateController = TextEditingController();
  final _priorityController = TextEditingController();
  final _indicationController = TextEditingController();
  final _procedureController = TextEditingController();
  final _surgeryController = TextEditingController();
  final _actionTypeController = TextEditingController();
  final _surgeryTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<CreatePatientViewmodel>().setNewPatientDetails(
          widget.selectedPatient ?? PatientModel.newInstance());

      _initializeControllers();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _regController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _phoneNumberController.dispose();
    _categoryController.dispose();
    _dobController.dispose();
    _dateController.dispose();
    _priorityController.dispose();
    _indicationController.dispose();
    _procedureController.dispose();
    _surgeryController.dispose();
    _actionTypeController.dispose();
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
        _age(context),
        _gender(context),
        _phoneNumber(context)
      ];

  List<Widget> _diagnosisInfoForm(BuildContext context) {
    var actionType = context.watch<CreatePatientViewmodel>().actionType;
    if (actionType == ActionType.surgery) {
      return [
        _indication(context),
        _diagnosisDate(context),
        _priority(context),
        _actionType(context),
        _surgery(context),
        _surgeryType(context),
      ];
    } else if (actionType == ActionType.endoscopy) {
      return [
        _indication(context),
        _diagnosisDate(context),
        _priority(context),
        _actionType(context),
        _surgery(context),
        _procedure(context),
      ];
    }
    return [
      _indication(context),
      _diagnosisDate(context),
      _priority(context),
      _actionType(context),
    ];
  }

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
          child: Text(
            widget.selectedPatient != null ? 'Update' : 'Create',
            style: TextStyle(
                color: CupertinoTheme.of(context).primaryContrastingColor,
                fontWeight: Styles.fontWeightSemiBold),
          ),
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
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      placeholder: 'Registration No.',
      maxLength: 25,
      keyboardType: TextInputType.text,
      controller: _regController,
    ));
  }

  Widget _category(BuildContext context) {
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
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      placeholder: 'First name',
      maxLength: 25,
      keyboardType: TextInputType.text,
      controller: _firstNameController,
    ));
  }

  Widget _lastName(BuildContext context) {
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
            maxLength: 30,
            keyboardType: TextInputType.text,
            controller: _lastNameController,
            placeholder: 'Last name'));
  }

  Widget _age(BuildContext context) {
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
            maxLength: 3,
            keyboardType: TextInputType.number,
            controller: _ageController,
            placeholder: 'Age'));
  }

  Widget _gender(BuildContext context) {
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _genderController,
      placeholder: 'Gender',
      pickerIndex: context.watch<CreatePatientViewmodel>().genderIndex,
      pickerList: context
          .select((CreatePatientViewmodel viewModel) => viewModel.genderList),
      pickerTitle: 'Gender',
      setNewIndex: (index) =>
          context.read<CreatePatientViewmodel>().setGenderIndex(index),
    ));
  }

  Widget _phoneNumber(BuildContext context) {
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
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      controller: _indicationController,
      placeholder: 'Indication / diagnosis',
      maxLength: 200,
      keyboardType: TextInputType.text,
    ));
  }

  Widget _diagnosisDate(BuildContext context) {
    return CupertinoFormRow(child:
        Consumer<CreatePatientViewmodel>(builder: (context, viewModel, child) {
      return CupertinoTextFormFieldRow(
        onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (_) => CustomDateTimePicker(
                  isDate: true,
                  value: viewModel.newPatient.diagnosis.date,
                  maxDate: DateTime(DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
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
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _procedureController,
      placeholder: 'Procedure',
      pickerIndex: context.watch<CreatePatientViewmodel>().procedureIndex,
      pickerList: context.select(
          (CreatePatientViewmodel viewModel) => viewModel.procedureList),
      pickerTitle: 'Procedure',
      setNewIndex: (index) =>
          context.read<CreatePatientViewmodel>().setProcedureIndex(index),
    ));
  }

  Widget _surgery(BuildContext context) {
    return CupertinoFormRow(
        child: CupertinoTextFormFieldRow(
      controller: _surgeryController,
      placeholder:
          '${context.watch<CreatePatientViewmodel>().actionType.string.capitalize()} details',
      maxLength: 200,
      keyboardType: TextInputType.name,
    ));
  }

  Widget _actionType(BuildContext context) {
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _actionTypeController,
      placeholder: 'Action type',
      pickerIndex: context.watch<CreatePatientViewmodel>().actionTypeIndex,
      pickerList: ActionType.values
          .map((action) => action.string.capitalize())
          .toList(),
      pickerTitle: 'Action type',
      setNewIndex: (index) =>
          context.read<CreatePatientViewmodel>().setActionTypeIndex(index),
    ));
  }

  Widget _surgeryType(BuildContext context) {
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _surgeryTypeController,
      placeholder: 'Surgery type',
      pickerIndex: context.watch<CreatePatientViewmodel>().surgeryTypeIndex,
      pickerList: context.select(
          (CreatePatientViewmodel viewModel) => viewModel.surgeryTypeList),
      pickerTitle: 'Surgery type',
      setNewIndex: (index) =>
          context.read<CreatePatientViewmodel>().setSurgeryTypeIndex(index),
    ));
  }

  Widget _priority(BuildContext context) {
    return CupertinoFormRow(
        child: CustomFormFieldPicker(
      controller: _priorityController,
      placeholder: 'Priority',
      pickerIndex: context.watch<CreatePatientViewmodel>().priorityIndex,
      pickerList: context
          .select((CreatePatientViewmodel viewModel) => viewModel.priorityList),
      pickerTitle: 'Priority',
      setNewIndex: (index) =>
          context.read<CreatePatientViewmodel>().setPriorityIndex(index),
    ));
  }

// endregion

  _initializeControllers() {
    //region personal controllers
    _regController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .registrationNo;
    _firstNameController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .name
        .firstName;
    _lastNameController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .name
        .lastName;
    _categoryController.text =
        context.read<CreatePatientViewmodel>().newPatient.personalInfo.category;
    _dobController.text =
        context.read<CreatePatientViewmodel>().newPatient.personalInfo.dob;
    _phoneNumberController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .phoneNumber;
    _genderController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .personalInfo
        .gender
        .capitalize();

    //endRegion

    //region Diagnosis controllers
    _indicationController.text =
        context.read<CreatePatientViewmodel>().newPatient.diagnosis.indication;
    _dateController.text = context
        .read<CreatePatientViewmodel>()
        .newPatient
        .diagnosis
        .diagnosisDateToString;
    _surgeryController.text =
        context.read<CreatePatientViewmodel>().newPatient.diagnosis.surgery;

    _actionTypeController.text = context.read<CreatePatientViewmodel>().actionType.string.capitalize();

    _priorityController.text =
        context.read<CreatePatientViewmodel>().newPatient.diagnosis.priority;

    _procedureController.text =
        context.read<CreatePatientViewmodel>().newPatient.diagnosis.procedure;
    _surgeryTypeController.text =
        context.read<CreatePatientViewmodel>().newPatient.diagnosis.surgeryType;

    //endRegion
  }

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
