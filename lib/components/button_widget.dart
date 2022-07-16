import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:lsd_form/lsd_form.dart';

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
    final formData =
        context.dependOnInheritedWidgetOfExactType<LsdFormProvider>();

    if (formData != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: formData.submitting,
        child: child.toWidth(context),
        builder: (context, submitting, child) => internalBuild(
          context,
          submitting: submitting,
          child: child!,
        ),
      );
    }

    return internalBuild(
      context,
      child: child.toWidth(context),
    );
  }

  Widget internalBuild(
    BuildContext context, {
    bool submitting = false,
    required Widget child,
  }) {
    final finalChild = submitting
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(color: Colors.white))
        : child;

    final onPress =
        submitting ? () => null : () => this.onPress?.perform(getContext, null);

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
