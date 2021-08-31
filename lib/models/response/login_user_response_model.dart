import 'package:wardeleven/models/response/response_model.dart';

import '../login_user_details_model.dart';

class LoginUserResponseModel extends ResponseModel {
  int internalCode;
  String message;
  final LoginUserDetailsModel? userData;

  LoginUserResponseModel({required this.internalCode, required this.message, this.userData})
      : super(internalCode, message);

  factory LoginUserResponseModel.fromJson(Map<String, dynamic> json) {
    var userData = LoginUserDetailsModel.fromJson(json['data']);
    return LoginUserResponseModel(
        internalCode: json['internalCode'], message: json['message'], userData: userData);
  }
}
