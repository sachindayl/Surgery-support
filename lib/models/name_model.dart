import 'package:surgery_support/base/constants/constants.dart';

class NameModel {
  String firstName;
  String lastName;

  NameModel({
    required this.firstName,
    required this.lastName,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  factory NameModel.newInstance() {
    return NameModel(
        firstName: Constants.emptyString, lastName: Constants.emptyString);
  }

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
      };
}
