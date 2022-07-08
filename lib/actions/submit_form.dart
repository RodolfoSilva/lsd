import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import '../components/form_widget.dart';

class SubmitFormAction extends LsdAction {
  SubmitFormAction(super.lsd);

  // @override
  // LsdAction fromJson(Map<String, dynamic> props) {
  //   return super.fromJson(props);
  // }

  @override
  Future<dynamic> perform(BuildContext context, dynamic params) async {
    final formData = FormDataWidget.of(context);
    final isValid = await formData.validate(context);
    print(formData.values);
    print(formData.errors);

    if (isValid) {
      debugPrint("Form is Valid");
      return true;
    } else {
      debugPrint("Form is Valid");
      return false;
    }
  }
}
