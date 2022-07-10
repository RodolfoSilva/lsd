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
  Future<dynamic> perform(
    BuildContext Function() getContext,
    dynamic params,
  ) async {
    final formData = LsdFormDataWidget.of(getContext());
    final isValid = await formData.validate(getContext);

    if (isValid) {
      await action.perform(getContext, formData.values);
    }

    return isValid;
  }
}
