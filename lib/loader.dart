import 'dart:io';

import 'package:dio/dio.dart';

Dio dio = Dio(BaseOptions(
  baseUrl:
      Platform.isAndroid ? 'http://10.0.2.2:4000' : 'http://localhost:4000',
  connectTimeout: 10000,
  receiveTimeout: 60000,
));

Future<Map<String, dynamic>> load(String resource) async {
  print(resource);
  final response = await dio.get(resource);
  print("LOADED: $resource");

  return Map<String, dynamic>.from(response.data);
}

class ApiService {
  Future<dynamic> post(String resource, Map<String, dynamic> data) async {
    final response = await dio.post(resource, data: data);

    if (response.data == null) {
      return null;
    }

    return Map<String, dynamic>.from(response.data);
  }
}
