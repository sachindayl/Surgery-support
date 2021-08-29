import 'package:flutter/material.dart';

class PatientProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Text('PatientProfileView'),
          ),
        ),
      ),
    );
  }
}