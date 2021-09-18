import 'package:wardeleven/base/constants/constants.dart';

import 'name_model.dart';

class PersonalInfoModel {
  PersonalInfoModel({
    required this.registrationNo,
    required this.category,
    required this.name,
    required this.gender,
    required this.age,
    required this.phoneNumber,
  });

  String registrationNo;
  String category;
  NameModel name;
  String gender;
  int? age;
  String phoneNumber;

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) =>
      PersonalInfoModel(
        registrationNo: json["registrationNo"],
        category: json["category"],
        name: NameModel.fromJson(json["name"]),
        gender: json["gender"],
        age: json["age"],
        phoneNumber: json["phoneNumber"],
      );

  factory PersonalInfoModel.newInstance() {
    return PersonalInfoModel(
        registrationNo: Constants.emptyString,
        category: "ORS",
        name: NameModel.newInstance(),
        gender: 'Male',
        age: null,
        phoneNumber: Constants.emptyString);
  }

  Map<String, dynamic> toJson() => {
        "registrationNo": registrationNo,
        "category": category,
        "name": name.toJson(),
        "gender": gender,
        "age": age,
        "phoneNumber": phoneNumber,
      };
}
