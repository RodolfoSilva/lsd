import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../controllers/busy_controller.dart';

class ButtonWidget extends LsdWidget {
  late final LsdWidget child;
  late final LsdAction? onPress;
  late final String variant;
  late final String loadingFor;

  ButtonWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    final variant = props["variant"] as String? ?? "button";
    loadingFor = props["loading_for"] as String? ?? "submitting";

    this.variant = variant.toLowerCase();

    child = lsd.parseWidget(props["child"]);
    onPress =
        props["on_press"] != null ? lsd.parseAction(props["on_press"]) : null;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final busyController = getContext().watch<BusyController>();
    return internalBuild(
      context,
      busy: busyController.isBusy(loadingFor),
      child: child.toWidget(context),
    );
  }

  Widget internalBuild(
    BuildContext context, {
    bool busy = false,
    required Widget child,
  }) {
    final finalChild = busy
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(color: Colors.white))
        : child;

    final onPress =
        busy ? () => null : () => this.onPress?.perform(getContext, null);

    if (variant == "text") {
      return TextButton(
        onPressed: onPress,
        child: finalChild,
      );
    }

    return ElevatedButton(
      onPressed: onPress,
      child: finalChild,
    );
  }
}
