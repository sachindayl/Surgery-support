
import 'package:wardeleven/base/constants/constants.dart';

class NameModel {
  String firstName;
  String lastName;

  NameModel({
    required this.firstName,
    required this.lastName,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        firstName: json["firstName"].toString().toUpperCase(),
        lastName: json["lastName"].toString().toUpperCase(),
      );

  factory NameModel.newInstance() {
    return NameModel(
        firstName: Constants.emptyString, lastName: Constants.emptyString);
  }

  Map<String, dynamic> toJson() => {
        "firstName": firstName.toLowerCase(),
        "lastName": lastName.toLowerCase(),
      };
}
