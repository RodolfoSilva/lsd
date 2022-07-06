import 'package:dio/dio.dart';

Future<Map<String, dynamic>> load(String resource) async {
  await Future.delayed(const Duration(milliseconds: 500));
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:4000/api',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  final response = await dio.get(resource);

  return Map<String, dynamic>.from(response.data);
}
