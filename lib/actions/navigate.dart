import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class NavigateAction extends LsdAction {
  NavigateAction(super.lsd);

  late bool reset;
  late bool replace;
  late String? result;
  late dynamic destination;
  late LsdAction? after;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    final destination = props["destination"];
    replace = props["replace"] == true;
    reset = props["reset"] == true;

    after = props["after"] != null ? lsd.parseAction(props["after"]) : null;
    result = props["result"];

    if (destination is Map) {
      final screen = Map<String, dynamic>.from(destination);
      this.destination = lsd.parseWidget(screen);
    } else if (destination is String) {
      this.destination = destination;
    }

    return super.fromJson(props);
  }

  _performLater(BuildContext Function() getContext,
      [Map<String, dynamic>? params]) {
    Future.microtask(() => after?.perform(getContext, params));
  }

  @override
  Future<dynamic> perform(
    BuildContext Function() getContext,
    dynamic params,
  ) async {
    if (destination == null) {
      return null;
    }

    final navigator = Navigator.of(getContext());

    if (destination is String) {
      navigator.pop(this.result);
      _performLater(getContext, {"result": this.result});
      return null;
    }

    int executionCount = 0;
    final pageRoute = MaterialPageRoute(
      builder: (context) {
        executionCount++ == 0 ? _performLater(getContext, params) : null;
        return (destination as LsdWidget).toWidth(context);
      },
    );

    if (reset) {
      final result = await navigator.pushAndRemoveUntil(
        pageRoute,
        (Route<dynamic> route) => false,
      );
      debugPrint(jsonEncode({"result": result}));
      return {"result": result};
    }

    if (replace) {
      final result = await navigator.pushReplacement(pageRoute);
      debugPrint(jsonEncode({"result": result}));
      return {"result": result};
    }

    final result = await navigator.push(pageRoute);
    debugPrint(jsonEncode({"result": result}));
    return {"result": result};
  }
}
