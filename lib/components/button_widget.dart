import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ButtonWidget extends LsdWidget {
  late final LsdWidget child;
  late final LsdAction? onPress;
  late String variant;

  ButtonWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    final variant = props["variant"] as String? ?? "button";

    this.variant = variant.toLowerCase();

    child = lsd.parseWidget(props["child"]);
    onPress =
        props["onPress"] != null ? lsd.parseAction(props["onPress"]) : null;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final child = this.child.toWidth(context);

    if (variant == "text") {
      return TextButton(
        onPressed: () => onPress?.perform(getContext, null),
        child: child,
      );
    }

    return ElevatedButton(
      onPressed: () => onPress?.perform(getContext, null),
      child: child,
    );
  }
}
