import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import '../components/form_widget.dart';

class RequiredValidationAction extends LsdAction {
  RequiredValidationAction(super.lsd);

  late String message;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    message = props["message"] ?? "Required!";

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(BuildContext context, dynamic params) async {
    if (params is! String) {
      return ValidationResult.invalid("Invalid type");
    }

    if (params == "") {
      return ValidationResult.invalid(message);
    }

    return ValidationResult.valid();
  }
}
