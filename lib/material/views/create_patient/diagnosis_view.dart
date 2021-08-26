import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:surgery_support/base/base_styles.dart';
import 'package:surgery_support/material/widgets/custom_date_picker.dart';
import 'package:surgery_support/material/widgets/custom_text_form_field.dart';
import 'package:surgery_support/material/widgets/form_field_dropdown.dart';
import 'package:surgery_support/material/widgets/form_row.dart';
import 'package:surgery_support/material/widgets/form_title.dart';
import 'package:surgery_support/shared/viewmodels/create_patient_viewmodel.dart';

import '../../material_styles.dart';

class DiagnosisView extends StatelessWidget {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create patient'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
        padding:
              const EdgeInsets.symmetric(horizontal: Styles.horizontalPadding, vertical: 8.0),
        child: Column(
            children: [
              FormTitle(title: 'Diagnosis information'),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: FormRow(
                    icon: Icon(Icons.assessment_outlined),
                    formField: CustomTextFormField(
                      label: 'Indication/diagnosis',
                    )),
              ),
              Padding(
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
                        onTap: () async => await CustomDatePicker(
                                selectedDate: viewModel.selectedDiagnosisDate,
                                newDateCallback: (newDate) {
                                  var inputFormat = DateFormat('dd/MM/yyyy');
                                  _dateController.text =
                                      inputFormat.format(newDate);
                                  viewModel.setDiagnosisDate(newDate);
                                },
                                firstDate: DateTime(1990, 1),
                                lastDate: DateTime.now())
                            .build(context));
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(
                  formField: Consumer<CreatePatientViewmodel>(
                      builder: (context, viewModel, child) {
                    return FormFieldDropdown(
                      label: 'Procedure',
                      listItems: viewModel.procedureList,
                    );
                  }),
                ),
              ),
              Padding(
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
                              border: Border.all(color: Styles.black.withOpacity(Styles.opacity51))
                        ),
                        child: ListTile(
                          title: Text('Outside', style: TextStyle(color: Styles.black.withOpacity(Styles.opacity64)),),
                          trailing: Checkbox(value: true, onChanged: (value) {}),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(
                    icon: Icon(Icons.cut),
                    formField: CustomTextFormField(
                      label: 'Surgery',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(
                  formField: Consumer<CreatePatientViewmodel>(
                      builder: (context, viewModel, child) {
                    return FormFieldDropdown(
                      label: 'Surgery type',
                      listItems: viewModel.surgeryTypeList,
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(
                  icon: Icon(Icons.priority_high),
                  formField: Consumer<CreatePatientViewmodel>(
                      builder: (context, viewModel, child) {
                    return FormFieldDropdown(
                      label: 'Priority',
                      listItems: viewModel.priorityList,
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormRow(
                    icon: Icon(Icons.notes),
                    formField: CustomTextFormField(
                      label: 'Remarks',
                    )),
              ),
              Padding(
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
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DiagnosisView())),
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
              ),
            ],
        ),
      ),
          )),
    );
  }
}
