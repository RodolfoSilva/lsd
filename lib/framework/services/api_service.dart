import 'package:dio/dio.dart';

import 'auth_service.dart';

typedef JSON = Map<String, dynamic>;

class ApiService {
  ApiService({
    required AuthService auth,
    required Dio dio,
  })  : _dio = dio,
        _auth = auth;

  final AuthService _auth;

  final Dio _dio;

  Future<Options?> _getRequestOptions({Map<String, dynamic>? headers}) async {
    final token = await _auth.getToken();

    if (token != null) {
      Map<String, dynamic> newHeaders = {
        'Authorization': token,
      }..addAll(headers ?? {});

      return Options(headers: newHeaders);
    }

    return Options(headers: headers);
  }

  Future<JSON?> get(
    String resource, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final options = await _getRequestOptions(headers: headers);
    final response = await _dio.get(
      resource,
      options: options,
      queryParameters: queryParameters,
    );

    if (response.data == null) {
      return null;
    }

    return JSON.from(response.data);
  }

  Future<JSON?> delete(
    String resource, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final options = await _getRequestOptions(headers: headers);
    final response = await _dio.delete(
      resource,
      options: options,
      queryParameters: queryParameters,
    );

    if (response.data == null) {
      return null;
    }

    return JSON.from(response.data);
  }

  Future<JSON?> post(
    String resource,
    JSON? data, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final options = await _getRequestOptions(headers: headers);
    final response = await _dio.post(
      resource,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );

    if (response.data == null) {
      return null;
    }

    return JSON.from(response.data);
  }

  Future<JSON?> put(
    String resource,
    JSON? data, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final options = await _getRequestOptions(headers: headers);
    final response = await _dio.put(
      resource,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );

    if (response.data == null) {
      return null;
    }

    return JSON.from(response.data);
  }
}
