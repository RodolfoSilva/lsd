import 'package:flutter/material.dart';

import '../models/method.dart';
import '../models/request.dart';
import '../services/api_service.dart';
import 'busy_controller.dart';

class ScreenController with ChangeNotifier {
  ScreenController({
    required this.path,
    required this.busyController,
    required this.apiService,
  }) {
    _fetchPath();
  }

  final String path;
  final ApiService apiService;
  BusyController busyController;
  Map<String, dynamic>? _body;
  bool _loading = false;
  Object? _error;
  StackTrace? _stackTrace;
  bool get isLoading => _loading;
  bool get hasError => _error != null;
  Object? get error => _error;
  StackTrace? get stackTrace => _stackTrace;
  Map<String, dynamic>? get body => _body;

  _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  _setError(Object error, StackTrace stackTrace) {
    _error = error;
    _stackTrace = stackTrace;
    notifyListeners();
  }

  _resetError() {
    _error = null;
    _stackTrace = null;
    notifyListeners();
  }

  Future<void> _fetchPath() async {
    _setLoading(true);
    _resetError();

    try {
      _body = await apiService.get(path);
      _setLoading(false);
    } catch (error, stackTrace) {
      _setError(error, stackTrace);
      _setLoading(false);
    }
  }

  void refresh() {
    _fetchPath();
  }

  Future<Map<String, dynamic>?> sendRequestToServer(Request request) async {
    busyController.setBusy(request.id, true);
    try {
      switch (request.method) {
        case Method.get:
          return await apiService.get(
            request.url,
            queryParameters: request.queryParameters,
            headers: request.headers,
          );
        case Method.delete:
          return await apiService.delete(
            request.url,
            queryParameters: request.queryParameters,
            headers: request.headers,
          );
        case Method.post:
          return await apiService.post(
            request.url,
            request.data,
            queryParameters: request.queryParameters,
            headers: request.headers,
          );
        case Method.put:
          return await apiService.put(
            request.url,
            request.data,
            queryParameters: request.queryParameters,
            headers: request.headers,
          );
      }
    } finally {
      busyController.setBusy(request.id, false);
    }
  }
}
