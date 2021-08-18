class FailureHandler {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  FailureHandler(this.message);

  @override
  String toString() => message;
}

class MilystoException implements Exception {
  String error;
  MilystoException(this.error);
}