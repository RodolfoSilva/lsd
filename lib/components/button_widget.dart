import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ButtonWidget extends LsdWidget {
  late final LsdWidget child;
  late final LsdAction? onPress;
  late String variant;

  ButtonWidget(super.serView);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    final variant = props["variant"] as String? ?? "button";

    this.variant = variant.toLowerCase();

    child = lsd.parseWidget(props["child"]);
    onPress =
        props["onPress"] != null ? lsd.parseAction(props["onPress"]) : null;
    return super.fromJson(props);
  }

  _onPressed(BuildContext context) => () => onPress?.perform(context, null);

  @override
  Widget build(BuildContext context) {
    final child = this.child.build(context);

    if (variant == "text") {
      return TextButton(onPressed: _onPressed(context), child: child);
    }

    return ElevatedButton(onPressed: _onPressed(context), child: child);
  }
}
