import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

///DioHttp initializer. This is used to make REST API calls to the backend.
class DioHttp {
  final String _testEndpointUrl = '';

  // final String _devEndpointUrl = 'http://127.0.0.1:5300/api/v1';

  final String _devEndpointUrl = 'http://10.0.2.2:5300/api/v1';

  static final DioHttp _instance = DioHttp._internal();

  factory DioHttp() {
    return _instance;
  }

  DioHttp._internal();

  Dio options() {
    return Dio(BaseOptions(
      baseUrl: kDebugMode ? _devEndpointUrl : _testEndpointUrl,
      connectTimeout: 5000,
      receiveTimeout: 30000,
    ));
  }

  Map<String, String> getHeaders(String accessToken) {
    return {
      'authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
  }
}
