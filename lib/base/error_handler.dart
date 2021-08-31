import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      throw FailureHandler('Cannot connect to the server.');
    } else if (e.error is HttpException) {
      throw FailureHandler("Couldn't find the post");
    } else if (e.error is FormatException) {
      throw FailureHandler("Bad response format");
    } else {
      throw FailureHandler('Unexpected error occurred.');
    }
  }

  Future handleError(Exception e) {
    throw FailureHandler("unexpected_error_occurred".tr());
  }

  Future handleMilystoError(MilystoException e) {
    throw FailureHandler(e.error);
  }

  Future handleFirebaseError(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      throw FailureHandler('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      throw FailureHandler('Wrong password provided for that user.');
    }
    throw FailureHandler('Unexpected authentication error occurred.');
  }
}
