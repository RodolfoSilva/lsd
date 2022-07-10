import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import '../lsd_form/lsd_form_data_widget.dart';
import '../lsd_form/lsd_form_field.dart';

class InputWidget extends LsdWidget {
  late String name;
  late String? initialValue;
  late List<LsdAction> validations;

  InputWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    name = props["name"];
    initialValue = props["initialValue"];
    validations = List<Map<String, dynamic>>.from(props["validations"] ?? [])
        .map((e) => lsd.parseAction(e))
        .toList();
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    LsdFormDataWidget.of(context)
        .register(name, initialValue ?? "", validations);

    return LsdFormFieldWidgetBuilder(
      name: name,
      builder: (context, controller, error, child) {
        return TextField(
          controller: controller,
          decoration: InputDecoration(errorText: error),
        );
      },
    );
  }
}
