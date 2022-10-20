import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:drosak/videos/api/api_client.dart';

Dio buildDioClient(String baseUrl) {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  // dio.options.connectTimeout = 5000;
  // dio.options.receiveTimeout = 3000;
  dio.options.headers = {
    'AccessKey': ApiClient.AccessKey,
    'content-type': 'application/*+json',
    'accept': 'application/json',
  };

  dio.interceptors.addAll([
    // LogInterceptor(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: true,
    //   error: true,
    // ),
    DioLoggingInterceptor(
      level: Level.body,
      compact: true,
    ),
  ]);
  return dio;
}
