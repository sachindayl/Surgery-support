class ResponseModel {
  int internalCode;
  String message;

  ResponseModel(this.internalCode, this.message);

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      json['internalCode'],
      json['message'],
    );
  }
}