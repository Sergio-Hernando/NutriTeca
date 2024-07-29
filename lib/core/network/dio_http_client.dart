import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const _defaultConnectTimeout = Duration.microsecondsPerMinute;
const _defaultReceiveTimeout = Duration.microsecondsPerMinute;

class DioClient {
  static List<Interceptor>? interceptors;
  static DioClient? _instance;
  static final Dio _dio = Dio();

  factory DioClient() => _instance ?? DioClient._internal();

  DioClient._internal() {
    _instance = this;
  }

  void addInterceptors() {
    _dio
      ..options.connectTimeout = _defaultConnectTimeout as Duration?
      ..options.receiveTimeout = _defaultReceiveTimeout as Duration?
      ..httpClientAdapter
      ..options.headers = {'ContentType': 'application/json'};

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
        requestBody: true,
      ));
    }
  }

  Dio getDio() {
    return _dio;
  }
}
