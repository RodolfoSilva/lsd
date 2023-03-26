import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class NavigateAction extends LsdAction {
  NavigateAction(super.lsd);

  late bool reset;
  late bool replace;
  late dynamic result;
  late dynamic destination;
  late LsdAction? callback;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    final destination = props["destination"];
    replace = props["replace"] == true;
    reset = props["reset"] == true;
    result = props["result"];
    callback = lsd.parseActionOrNull(props["callback"]);

    if (destination is Map) {
      final screen = Map<String, dynamic>.from(destination);
      this.destination = lsd.parseWidget(screen);
    } else if (destination is String) {
      this.destination = destination;
    }

    return super.fromJson(props);
  }

  _performCallback(GetContext getContext, [dynamic params]) {
    Future.microtask(() => callback?.perform(getContext, params));
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    if (destination == null) {
      return null;
    }

    if (_isPopRoute(destination)) {
      final navigator = Navigator.of(getContext());
      navigator.pop(result);
      _performCallback(getContext, params);
      return null;
    }

    if (_isNamedRoute(destination)) {
      return _pushNamed(getContext(), destination);
    }

    int executionCount = 0;
    return _pushDynamic(
      getContext(),
      MaterialPageRoute(
        builder: (context) {
          executionCount++ == 0 ? _performCallback(getContext, params) : null;
          return (destination as LsdWidget).toWidget(context);
        },
      ),
    );
  }

  bool _isPopRoute(dynamic route) {
    return route is String && route == "../";
  }

  bool _isNamedRoute(dynamic route) {
    return route is String && route.toLowerCase().startsWith("route://");
  }

  Future<dynamic> _pushNamed(BuildContext context, String destination) {
    final navigator = Navigator.of(context);

    final path = destination.replaceFirst(RegExp(r'route:\/\/'), '');

    if (reset) {
      return navigator.pushNamedAndRemoveUntil(
        path,
        (Route<dynamic> route) => false,
      );
    }

    if (replace) {
      return navigator.pushReplacementNamed(path);
    }
    return navigator.pushNamed(path);
  }

  Future<dynamic> _pushDynamic(BuildContext context, Route pageRoute) {
    final navigator = Navigator.of(context);

    if (reset) {
      return navigator.pushAndRemoveUntil(
        pageRoute,
        (Route<dynamic> route) => false,
      );
    }

    if (replace) {
      return navigator.pushReplacement(pageRoute);
    }

    return navigator.push(pageRoute);
  }
}
