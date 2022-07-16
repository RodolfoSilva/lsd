import 'package:flutter/widgets.dart';

import 'lsd_route_controller.dart';

class LsdRouteControllerProvider extends InheritedWidget {
  const LsdRouteControllerProvider({
    Key? key,
    required Widget child,
    required LsdRouteController controller,
  })  : _controller = controller,
        super(key: key, child: child);

  final LsdRouteController _controller;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static LsdRouteController of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<LsdRouteControllerProvider>();
    assert(result != null, 'No LsdRouteControllerProvider found in context');
    return result!._controller;
  }
}
