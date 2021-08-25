
import 'package:flutter/material.dart';
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
          child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Styles.horizontalPadding),
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
                                newDateCallback: (newDate) =>
                                    viewModel.setDiagnosisDate(newDate))
                            .build(context));
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FormRow(
                formField: FormFieldDropdown(
                  label: 'Procedure',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MaterialStyles.iconSizedBoxWidth,
                  ),
                  Expanded(
                      child: Text(
                    'Outside',
                    style: TextStyle(fontSize: Styles.fontSize16),
                  )),
                  Checkbox(value: true, onChanged: (value) {}),
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
                formField: FormFieldDropdown(
                  label: 'Surgery type',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FormRow(
                icon: Icon(Icons.priority_high),
                formField: FormFieldDropdown(
                  label: 'Priority',
                ),
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
          ],
        ),
      )),
    );
  }
}
