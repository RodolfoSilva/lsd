import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_data_widget.dart';

class LsdSubmitFormAction extends LsdAction {
  LsdSubmitFormAction(super.lsd);

  late final LsdAction action;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    action = lsd.parseAction(props["action"]);
    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(BuildContext context, dynamic params) async {
    final formData = LsdFormDataWidget.of(context);
    final isValid = await formData.validate(context);

    if (isValid) {
      // ignore: use_build_context_synchronously
      await action.perform(context, formData.values);
    }

    return isValid;
  }
}
