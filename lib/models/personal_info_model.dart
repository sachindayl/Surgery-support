import 'package:wardeleven/base/constants/constants.dart';
import 'package:wardeleven/models/gender_model.dart';
import 'package:wardeleven/models/service_category_model.dart';

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
  ServiceCategory category;
  NameModel name;
  Gender gender;
  int? age;
  String phoneNumber;

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) =>
      PersonalInfoModel(
        registrationNo: json["registrationNo"].toString().toUpperCase(),
        category: json["category"].toString().toUpperCase().category,
        name: NameModel.fromJson(json["name"]),
        gender: json["gender"].toString().toUpperCase().gender,
        age: json["age"],
        phoneNumber: json["phoneNumber"],
      );

  factory PersonalInfoModel.newInstance() {
    return PersonalInfoModel(
        registrationNo: Constants.emptyString,
        category: ServiceCategory.ors,
        name: NameModel.newInstance(),
        gender: Gender.male,
        age: -1,
        phoneNumber: Constants.emptyString);
  }

  Map<String, dynamic> toJson() => {
        "registrationNo": registrationNo.toLowerCase(),
        "category": category.string.toLowerCase(),
        "name": name.toJson(),
        "gender": gender.string.toLowerCase(),
        "age": age,
        "phoneNumber": phoneNumber,
      };
}
