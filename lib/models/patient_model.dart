import 'dart:convert';


import 'package:wardeleven/models/personal_info_model.dart';

import 'diagnosis_model.dart';

PatientModel patientModelFromJson(String str) =>
    PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  PatientModel({
    this.id,
    required this.personalInfo,
    required this.diagnosis,
  });

  String? id;
  PersonalInfoModel personalInfo;
  DiagnosisModel diagnosis;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["id"],
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
