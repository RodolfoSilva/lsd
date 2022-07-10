import 'package:dio/dio.dart';

Dio dio = Dio(BaseOptions(
  baseUrl: 'http://localhost:4000/api',
  connectTimeout: 5000,
  receiveTimeout: 3000,
));

Future<Map<String, dynamic>> load(String resource) async {
  await Future.delayed(const Duration(milliseconds: 500));

  final response = await dio.get(resource);

  return Map<String, dynamic>.from(response.data);
}

class ApiService {
  Future<dynamic> post(String resource, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final response = await dio.post(resource, data: data);

    if (response.data == null) {
      return null;
    }

    return Map<String, dynamic>.from(response.data);
  }
}
