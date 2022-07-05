import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class NavigateAction extends LsdAction {
  NavigateAction(super.lsd);

  late bool reset;
  late bool replace;
  late dynamic destination;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    final destination = props["destination"];
    replace = props["replace"] == true;
    reset = props["reset"] == true;

    if (destination is Map) {
      final screen = Map<String, dynamic>.from(destination);
      this.destination = lsd.parseWidget(screen);
    } else if (destination is String) {
      this.destination = destination;
    }

    return super.fromJson(props);
  }

  @override
  Map<String, dynamic>? perform(
      BuildContext context, Map<String, dynamic>? result) {
    if (destination == null) {
      return null;
    }

    if (destination is String) {
      Navigator.pop(context);
    }

    if (reset) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => (destination as LsdWidget).build(context),
          ),
          (Route<dynamic> route) => false);
      return null;
    }

    if (replace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (destination as LsdWidget).build(context),
        ),
      );
      return null;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => (destination as LsdWidget).build(context),
      ),
    );
    return null;
  }
}
