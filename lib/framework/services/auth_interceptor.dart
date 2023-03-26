import 'dart:io';

import 'package:dio/dio.dart';

import 'auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService _authService;

  AuthInterceptor({
    required AuthService authService,
  }) : _authService = authService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      "Content-type": ContentType.json.toString(),
    });

    final token = await _authService.getToken();

    if (token?.isNotEmpty == true) {
      options.headers.addAll({
        "Authorization": token,
      });
    }

    handler.next(options);
  }
}
