import 'package:dio/dio.dart';
import 'package:task_cinema_app/core/constants/secrets.dart';
import '../conf/env.dart';
import '../constants/api_constants.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Authorization': 'Bearer ${Secrets.tmdbToken}',
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
}
