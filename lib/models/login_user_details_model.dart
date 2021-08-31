class LoginUserDetailsModel {
  String? displayName;
  String? email;

  LoginUserDetailsModel(this.displayName, this.email);

  factory LoginUserDetailsModel.fromJson(Map<String, dynamic> json) {
    return LoginUserDetailsModel(
      json['displayName'],
      json['email'],
    );
  }
}