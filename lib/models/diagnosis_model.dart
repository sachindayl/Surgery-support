import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:wardeleven/base/constants/constants.dart';

class DiagnosisModel {
  DiagnosisModel({
    required this.indication,
    required this.date,
    required this.procedure,
    required this.isOutside,
    required this.surgery,
    required this.surgeryType,
    required this.priority,
  });

  String indication;
  DateTime date;
  String procedure;
  bool isOutside;
  String surgery;
  String surgeryType;
  String priority;

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    log("in diagnosis");
    var date = (json["date"] as String).split('T');
    return DiagnosisModel(
        indication: json["indication"],
        date: DateFormat('yy-MM-dd').parse(date[0]),
        procedure: json["procedure"],
        isOutside: json["isOutside"],
        surgery: json["surgery"],
        surgeryType: json["surgeryType"],
        priority: json["priority"],
      );
  }

  factory DiagnosisModel.newInstance() {
    return DiagnosisModel(
        indication: Constants.emptyString,
        date: DateTime.now(),
        procedure: 'Upper GI',
        isOutside: false,
        surgery: Constants.emptyString,
        surgeryType: 'Major',
        priority: 'Low');
  }

  Map<String, dynamic> toJson() => {
        "indication": indication,
        "date": date.toIso8601String(),
        "procedure": procedure,
        "isOutside": isOutside,
        "surgery": surgery,
        "surgeryType": surgeryType,
        "priority": priority,
      };

  // DateTime get formattedDiagnosisDate {
  //   if(date == Constants.emptyString) {
  //     return DateTime.now();
  //   }
  //   return DateFormat('dd/MM/yyyy').parse(date);
  // }

  // void setDiagnosisDate(DateTime newDate) {
  //   date = DateFormat('dd/MM/yyyy').format(newDate);
  // }

  String get diagnosisDateToString => DateFormat('dd/MM/yyyy').format(date);
}
