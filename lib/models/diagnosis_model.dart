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
    required this.remarks,
  });

  String indication;
  String date;
  String procedure;
  bool isOutside;
  String surgery;
  String surgeryType;
  String priority;
  String remarks;

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
        indication: json["indication"],
        date: json["date"],
        procedure: json["procedure"],
        isOutside: json["isOutside"],
        surgery: json["surgery"],
        surgeryType: json["surgeryType"],
        priority: json["priority"],
        remarks: json["remarks"],
      );

  factory DiagnosisModel.newInstance() {
    return DiagnosisModel(
        indication: Constants.emptyString,
        date: Constants.emptyString,
        procedure: Constants.emptyString,
        isOutside: false,
        surgery: Constants.emptyString,
        surgeryType: Constants.emptyString,
        priority: Constants.emptyString,
        remarks: Constants.emptyString);
  }

  Map<String, dynamic> toJson() => {
        "indication": indication,
        "date": date,
        "procedure": procedure,
        "isOutside": isOutside,
        "surgery": surgery,
        "surgeryType": surgeryType,
        "priority": priority,
        "remarks": remarks,
      };

  DateTime get formattedDiagnosisDate {
    if(date == Constants.emptyString) {
      return DateTime.now();
    }
    return DateFormat('dd/MM/yyyy').parse(date);
  }

  void setDiagnosisDate(DateTime newDate) {
    date = DateFormat('dd/MM/yyyy').format(newDate);
  }
}
