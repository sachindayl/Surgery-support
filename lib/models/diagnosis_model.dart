import 'package:intl/intl.dart';
import 'package:wardeleven/base/constants/constants.dart';
import 'package:wardeleven/models/action_type_model.dart';
import 'package:wardeleven/models/priority_model.dart';
import 'package:wardeleven/models/surgery_type_model.dart';

class DiagnosisModel {
  String indication;
  DateTime date;
  String? procedure;
  ActionType actionType;
  String? surgery;
  SurgeryType? surgeryType;
  Priority priority;

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
      indication: json["indication"].toString().toUpperCase(),
      date: DateFormat('yy-MM-dd').parse(date[0]),
      procedure: json["procedure"].toString().toUpperCase(),
      actionType: json["actionType"].toString().toUpperCase().actionType,
      surgery: json["surgery"].toString().toUpperCase(),
      surgeryType: json["surgeryType"].toString().toUpperCase().surgeryType,
      priority: json["priority"].toString().toUpperCase().priority,
    );
  }

  factory DiagnosisModel.newInstance() {
    return DiagnosisModel(
        indication: Constants.emptyString,
        date: DateTime.now(),
        procedure: 'None',
        actionType: ActionType.review,
        surgery: Constants.emptyString,
        surgeryType: SurgeryType.none,
        priority: Priority.high);
  }

  Map<String, dynamic> toJson() => {
        "indication": indication.toLowerCase(),
        "date": date.toIso8601String(),
        "procedure": procedure?.toLowerCase(),
        "actionType": actionType.string.toLowerCase(),
        "surgery": surgery?.toLowerCase(),
        "surgeryType": surgeryType.string.toLowerCase(),
        "priority": priority.string.toLowerCase(),
      };

  String get diagnosisDateToString => DateFormat('dd/MM/yyyy').format(date);
}
