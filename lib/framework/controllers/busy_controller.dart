import 'package:flutter/material.dart';

class BusyController extends ChangeNotifier {
  final Map<String, int> _state = {};

  bool isBusy(id) {
    if (id == "*") {
      return _state.isNotEmpty;
    }
    return (_state[id] ?? 0) > 0;
  }

  void setBusy(String id, bool busy) {
    if (busy) {
      _state[id] = (_state[id] ?? 0) + 1;
    } else {
      _state[id] = (_state[id] ?? 1) - 1;
    }
    if (_state[id] != null && _state[id]! <= 0) {
      _state.remove(id);
    }

    notifyListeners();
  }
}
