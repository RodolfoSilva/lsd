import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ButtonWidget extends LsdWidget {
  late final LsdWidget child;
  late final LsdAction? onPress;

  ButtonWidget(super.serView);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    onPress =
        props["onPress"] != null ? lsd.parseAction(props["onPress"]) : null;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: child.build(context),
      onPressed: () => onPress?.perform(context, null),
    );
  }
}
