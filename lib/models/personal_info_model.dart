import 'package:intl/intl.dart';
import 'package:wardeleven/base/constants/constants.dart';

import 'name_model.dart';

class PersonalInfoModel {
  PersonalInfoModel({
    required this.registrationNo,
    required this.category,
    required this.name,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
  });

  String registrationNo;
  String category;
  NameModel name;
  String gender;
  String dob;
  String phoneNumber;

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) =>
      PersonalInfoModel(
        registrationNo: json["registrationNo"],
        category: json["category"],
        name: NameModel.fromJson(json["name"]),
        gender: json["gender"],
        dob: json["dob"],
        phoneNumber: json["phoneNumber"],
      );

  factory PersonalInfoModel.newInstance() {
    return PersonalInfoModel(
        registrationNo: Constants.emptyString,
        category: "ORS",
        name: NameModel.newInstance(),
        gender: 'Male',
        dob: Constants.emptyString,
        phoneNumber: Constants.emptyString);
  }

  Map<String, dynamic> toJson() => {
        "registrationNo": registrationNo,
        "category": category,
        "name": name.toJson(),
        "gender": gender,
        "dob": dob,
        "phoneNumber": phoneNumber,
      };

  DateTime get formattedDob {
    if (dob == Constants.emptyString) {
      return DateTime.now();
    }
    return DateFormat('dd/MM/yyyy').parse(dob);
  }

  void setDob(DateTime newDate) {
    dob = DateFormat('dd/MM/yyyy').format(newDate);
  }
}
