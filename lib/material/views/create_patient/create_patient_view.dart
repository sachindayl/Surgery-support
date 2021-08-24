import 'package:flutter/material.dart';
import 'package:surgery_support/base/base_styles.dart';
import 'package:surgery_support/material/views/main_container/main_container.dart';
import 'package:surgery_support/material/widgets/form_field_dropdown.dart';

import '../../material_styles.dart';

class CreatePatientView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Patient'),
      ),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: Styles.horizontalPadding),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  'Personal Information',
                  style: TextStyle(
                      color: Styles.black.withOpacity(Styles.opacity87),
                      fontSize: Styles.fontSize19,
                      fontWeight: Styles.fontWeightSemiBold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: Icon(Icons.app_registration),
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Registration No',
                      )),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50.0,
                  ),
                  Expanded(child: FormFieldDropdown(label: 'Category')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: Icon(Icons.person),
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First name',
                      )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last name',
                      )),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50.0,
                    child: Icon(Icons.female),
                  ),
                  Expanded(child: FormFieldDropdown(label: 'Sex')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: Icon(Icons.cake),
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Age',
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: Icon(Icons.phone),
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Telephone no.',
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
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
                      onPressed: () => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                          builder: (context) => MainContainer())),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
