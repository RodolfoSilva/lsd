import 'package:flutter/widgets.dart';

import 'screen_state.dart';

class ScreenInheritedWidget extends InheritedWidget {
  const ScreenInheritedWidget({
    Key? key,
    required ScreenState state,
    required Widget child,
  })  : _state = state,
        super(key: key, child: child);

  final ScreenState _state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  void setBusy(bool busy) {
    _state.setBusy(busy);
  }

  static ScreenInheritedWidget of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ScreenInheritedWidget>();
    assert(result != null, 'No ScreenWidget found in context');
    return result!;
  }
}
