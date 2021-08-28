import 'dart:convert';

import 'package:surgery_support/models/personal_info_model.dart';

import 'diagnosis_model.dart';

PatientModel patientModelFromJson(String str) =>
    PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  PatientModel({
    required this.personalInfo,
    required this.diagnosis,
  });

  PersonalInfoModel personalInfo;
  DiagnosisModel diagnosis;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        personalInfo: PersonalInfoModel.fromJson(json["personalInfo"]),
        diagnosis: DiagnosisModel.fromJson(json["diagnosis"]),
      );

  Map<String, dynamic> toJson() => {
        "personalInfo": personalInfo.toJson(),
        "diagnosis": diagnosis.toJson(),
      };

  factory PatientModel.newInstance() {
    return PatientModel(
        personalInfo: PersonalInfoModel.newInstance(),
        diagnosis: DiagnosisModel.newInstance());
  }
}
