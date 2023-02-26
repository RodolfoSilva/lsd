import 'dart:io';

import 'package:dio/dio.dart';

import 'auth_service.dart';

typedef JSON = Map<String, dynamic>;

class ApiService {
  ApiService(this.auth);

  final AuthService auth;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          Platform.isAndroid ? 'http://10.0.2.2:4000' : 'http://localhost:4000',
      connectTimeout: 10000,
      receiveTimeout: 60000,
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));

  Future<Options?> _getRequestOptions() async {
    final token = await auth.getToken();

    if (token != null) {
      return Options(headers: {
        'Authorization': token,
      });
    }
    return null;
  }

  Future<JSON?> get(String resource) async {
    final options = await _getRequestOptions();
    final response = await _dio.get(resource, options: options);

    if (response.data == null) {
      return null;
    }

    return JSON.from(response.data);
  }

  Future<JSON?> post(String resource, JSON data) async {
    final response = await _dio.post(
      resource,
      data: data,
      options: await _getRequestOptions(),
    );

    if (response.data == null) {
      return null;
    }

    return JSON.from(response.data);
  }
}
