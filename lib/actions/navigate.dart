import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class NavigateAction extends LsdAction {
  NavigateAction(super.lsd);

  late bool reset;
  late bool replace;
  late dynamic result;
  late dynamic destination;
  late LsdAction? after;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    final destination = props["destination"];
    replace = props["replace"] == true;
    reset = props["reset"] == true;

    after = props["after"] != null ? lsd.parseAction(props["after"]) : null;
    result = lsd.isAction(props["result"])
        ? lsd.parseAction(Map<String, dynamic>.from(props["result"]))
        : props["result"];

    if (destination is Map) {
      final screen = Map<String, dynamic>.from(destination);
      this.destination = lsd.parseWidget(screen);
    } else if (destination is String) {
      this.destination = destination;
    }

    return super.fromJson(props);
  }

  _performLater(GetContext getContext, [dynamic params]) {
    Future.microtask(() => after?.perform(getContext, params));
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    if (destination == null) {
      return null;
    }

    final navigator = Navigator.of(getContext());

    if (destination is String && "../" == destination) {
      dynamic result = this.result is LsdAction
          ? await this.result.perform(getContext, params)
          : this.result;

      navigator.pop(result);

      _performLater(getContext, result);
      return null;
    }

    if (destination is String &&
        (destination as String).toLowerCase().startsWith("route://")) {
      final path =
          (destination as String).replaceFirst(RegExp(r'route:\/\/'), '');

      return navigator.pushNamed(path);
    }

    int executionCount = 0;
    final pageRoute = MaterialPageRoute(
      builder: (context) {
        executionCount++ == 0 ? _performLater(getContext, params) : null;
        return (destination as LsdWidget).toWidget(context);
      },
    );

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
