import 'package:dio/dio.dart';

typedef JSON = Map<String, dynamic>;

class ApiService {
  ApiService({required Dio dio}) : _dio = dio;

  final Dio _dio;
  Future<JSON?> get(
    String resource, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.get(
      resource,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );

    return _parseResponse(response);
  }

  Future<JSON?> delete(
    String resource, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.delete(
      resource,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );

    return _parseResponse(response);
  }

  Future<JSON?> post(
    String resource,
    JSON? data, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.post(
      resource,
      data: data,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );

    return _parseResponse(response);
  }

  Future<JSON?> put(
    String resource,
    JSON? data, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.put(
      resource,
      data: data,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );

    return _parseResponse(response);
  }

  Future<JSON?> _parseResponse(Response response) async {
    if (response.data == null) {
      return null;
    }

    return JSON.from(response.data);
  }
}
