import 'package:intl/intl.dart';
import 'package:wardeleven/base/constants/constants.dart';

class DiagnosisModel {
  String indication;
  DateTime date;
  String? procedure;
  String actionType;
  String? surgery;
  String? surgeryType;
  String priority;

  DiagnosisModel({
    required this.indication,
    required this.date,
    required this.procedure,
    required this.actionType,
    required this.surgery,
    required this.surgeryType,
    required this.priority,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    var date = (json["date"] as String).split('T');
    return DiagnosisModel(
      indication: json["indication"],
      date: DateFormat('yy-MM-dd').parse(date[0]),
      procedure: json["procedure"],
      actionType: json["actionType"],
      surgery: json["surgery"],
      surgeryType: json["surgeryType"],
      priority: json["priority"],
    );
  }

  factory DiagnosisModel.newInstance() {
    return DiagnosisModel(
        indication: Constants.emptyString,
        date: DateTime.now(),
        procedure: 'None',
        actionType: 'Review',
        surgery: Constants.emptyString,
        surgeryType: 'None',
        priority: 'Low');
  }

  Map<String, dynamic> toJson() => {
        "indication": indication,
        "date": date.toIso8601String(),
        "procedure": procedure,
        "actionType": actionType,
        "surgery": surgery,
        "surgeryType": surgeryType,
        "priority": priority,
      };

  String get diagnosisDateToString => DateFormat('dd/MM/yyyy').format(date);
}
