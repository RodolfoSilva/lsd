import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_data_widget.dart';

class LsdSubmitFormAction extends LsdAction {
  const LsdSubmitFormAction(super.lsd);

  @override
  Future<dynamic> perform(BuildContext context, dynamic params) async {
    final formData = LsdFormDataWidget.of(context);
    final isValid = await formData.validate(context);

    return isValid;
  }
}
