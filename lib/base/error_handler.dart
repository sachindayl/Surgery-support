import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'failure_handler.dart';

class ErrorHandler {
  static final ErrorHandler _instance = ErrorHandler._internal();

  factory ErrorHandler() {
    return _instance;
  }

  ErrorHandler._internal();

  Future handleNetworkError(DioError e) async {
    // var error = ErrorDataResponseModel.fromJson(e.response.data);
    if (e.error is SocketException) {
      throw FailureHandler("cannot_connect_server".tr());
    } else if (e.error is HttpException) {
      throw FailureHandler("Couldn't find the post");
    } else if (e.error is FormatException) {
      throw FailureHandler("Bad response format");
    } else {
      throw FailureHandler("unexpected_network_error_occurred".tr());
    }
  }

  Future handleError(Exception e) {
    throw FailureHandler("unexpected_error_occurred".tr());
  }

  Future handleMilystoError(MilystoException e) {
    throw FailureHandler(e.error);
  }
}
