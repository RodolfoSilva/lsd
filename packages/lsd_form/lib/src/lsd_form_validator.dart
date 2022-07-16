import 'package:flutter/widgets.dart';
import 'package:lsd/lsd.dart';

import 'lsd_validation_result.dart';

class LsdFormValidator {
  LsdFormValidator(this.validations);

  final List<LsdAction> validations;

  Future<LsdValidationResult> validate(
      BuildContext Function() getContext, String value) async {
    for (final validation in validations) {
      final result = await validation.perform(getContext, value);

      if (result is LsdValidationResult) {
        return result;
      }

      if (result != null && !!result) {
        return LsdValidationResult.valid();
      } else {
        return LsdValidationResult.invalid("Unknown error");
      }
    }

    return LsdValidationResult.valid();
  }
}
