import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class FormWidget extends LsdWidget {
  late LsdWidget child;

  FormWidget(super.serView);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return FormDataWidget(
      child: Builder(
        builder: (context) => child.build(context),
      ),
    );
  }
}

class FormDataWidget extends InheritedWidget {
  const FormDataWidget({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static FormDataWidget of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FormDataWidget>();
    assert(result != null, 'No FormWidget found in context');
    return result!;
  }
}
