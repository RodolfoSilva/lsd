import 'package:flutter/widgets.dart';

class ScreenState {
  final ValueNotifier<bool> _busy = ValueNotifier(false);

  ValueNotifier<bool> get busy => _busy;
  bool get isBusy => _busy.value;

  void setBusy(bool busy) {
    _busy.value = busy;
  }
}
