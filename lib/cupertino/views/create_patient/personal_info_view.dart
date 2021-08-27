import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:surgery_support/base/base_styles.dart';
import 'package:surgery_support/cupertino/views/create_patient/diagnosis_view.dart';
import 'package:surgery_support/cupertino/widgets/custom_date_time_picker.dart';
import 'package:surgery_support/cupertino/widgets/custom_form_field_picker.dart';
import 'package:surgery_support/shared/viewmodels/create_patient_viewmodel.dart';

class PersonalInfoView extends StatelessWidget {
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();

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
                  backgroundColor:
                      CupertinoTheme.of(context).scaffoldBackgroundColor,
                  children: <Widget>[
                    CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                      placeholder: 'Registration No.',
                      maxLength: 25,
                      keyboardType: TextInputType.name,
                    )),
                    CupertinoFormRow(
                        child: CustomFormFieldPicker(
                      controller: _categoryController,
                      placeholder: 'Category',
                      pickerIndex:
                          context.watch<CreatePatientViewmodel>().categoryIndex,
                      pickerList: context.select(
                          (CreatePatientViewmodel viewModel) =>
                              viewModel.categoryList),
                      pickerTitle: 'Category',
                      setNewIndex: (index) => context
                          .read<CreatePatientViewmodel>()
                          .setCategory(index),
                    )),
                    CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                      placeholder: 'First name',
                      maxLength: 25,
                      keyboardType: TextInputType.text,
                    )),
                    CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                      maxLength: 25,
                      keyboardType: TextInputType.text,
                      placeholder: 'Last name',
                    )),
                    CupertinoFormRow(child: Consumer<CreatePatientViewmodel>(
                        builder: (context, viewModel, child) {
                      return CupertinoTextFormFieldRow(
                        onTap: () => showCupertinoModalPopup(
                            context: context,
                            builder: (_) => CustomDateTimePicker(
                                  isDate: true,
                                  value: viewModel
                                      .newPatient.diagnosis.formattedDiagnosisDate,
                                  maxDate: DateTime.now(),
                                  minDate: DateTime(1900,1),
                                  valueCallback: (updatedDate) {
                                    _dateController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(updatedDate);
                                    viewModel.newPatient.diagnosis
                                        .setDiagnosisDate(updatedDate);
                                    viewModel.setNewPatientDetails(
                                        viewModel.newPatient);
                                  },
                                )),
                        placeholder: 'Date of birth',
                        readOnly: true,
                        controller: _dateController,
                        style: TextStyle(
                            color: Styles.black.withOpacity(Styles.opacity87)),
                        keyboardType: TextInputType.name,
                      );
                    })),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
