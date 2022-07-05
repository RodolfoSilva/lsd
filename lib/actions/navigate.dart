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

  _performLater(BuildContext context, [Map<String, dynamic>? params]) {
    Future.microtask(() => after?.perform(context, params));
  }

  @override
  Future<Map<String, dynamic>?> perform(
    BuildContext context,
    Map<String, dynamic>? initialResult,
  ) async {
    if (destination == null) {
      return null;
    }

    if (destination is String) {
      Navigator.pop(context, this.result);
      _performLater(context, {"result": this.result});
      return null;
    }

    int executionCount = 0;
    final pageRoute = MaterialPageRoute(
      builder: (context) {
        executionCount++ == 0
            ? _performLater(context, {"result": initialResult})
            : null;
        return (destination as LsdWidget).build(context);
      },
    );

    if (reset) {
      final result = await Navigator.pushAndRemoveUntil(
        context,
        pageRoute,
        (Route<dynamic> route) => false,
      );
      debugPrint(jsonEncode({"result": result}));
      return {"result": result};
    }

    if (replace) {
      final result = await Navigator.pushReplacement(
        context,
        pageRoute,
      );
      debugPrint(jsonEncode({"result": result}));
      return {"result": result};
    }

    final result = await Navigator.push(
      context,
      pageRoute,
    );
    debugPrint(jsonEncode({"result": result}));
    return {"result": result};
  }
}
