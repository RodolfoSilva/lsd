import 'package:flutter/material.dart';

import 'services/api_service.dart';

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

  Future<Map<String, dynamic>?> getFromServer(
    String endpoint, {
    bool silent = false,
  }) async {
    if (!silent) setBusy(true);
    try {
      return await apiService.get(endpoint);
    } finally {
      if (!silent) setBusy(false);
    }
  }

  Future<Map<String, dynamic>?> sendToServer(
    String endpoint,
    JSON params, {
    bool silent = false,
  }) async {
    if (!silent) setBusy(true);
    try {
      return await apiService.post(endpoint, params);
    } finally {
      if (!silent) setBusy(false);
    }
  }
}
