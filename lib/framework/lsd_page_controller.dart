import 'package:flutter/material.dart';

import 'models/method.dart';
import 'models/request.dart';
import 'services/api_service.dart';

enum MethodEnum {
  get("get"),
  post("post"),
  put("put"),
  delete("delete");

  final String _value;
  const MethodEnum(this._value);

  static MethodEnum fromString(String method) {
    switch (method) {
      case "get":
        return MethodEnum.get;
      case "post":
        return MethodEnum.post;
      case "put":
        return MethodEnum.put;
      case "delete":
        return MethodEnum.delete;
      default:
        return MethodEnum.post;
    }
  }

  @override
  String toString() => _value;
}

class LsdPageController with ChangeNotifier {
  LsdPageController({required this.path, required this.apiService}) {
    _fetchPath();
  }

  final String path;
  final ApiService apiService;
  Map<String, dynamic>? _body;
  bool _loading = false;
  bool _busy = false;
  Object? _error;
  StackTrace? _stackTrace;
  bool get isLoading => _loading;
  bool get isBusy => _busy;
  bool get hasError => _error != null;
  Object? get error => _error;
  StackTrace? get stackTrace => _stackTrace;
  Map<String, dynamic>? get body => _body;

  _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setBusy(bool busy) {
    _busy = busy;
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
    setBusy(true);
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
      setBusy(false);
    }
  }
}
