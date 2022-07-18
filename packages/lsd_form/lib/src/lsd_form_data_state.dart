import 'package:flutter/widgets.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_validator.dart';

class LsdFormDataState {
  LsdFormDataState({required this.values});

  final Map<String, LsdFormValidator> validations = {};
  Map<String, dynamic> values;
  final ValueNotifier<bool> _submitting = ValueNotifier(false);
  final ValueNotifier<Map<String, String>> errors = ValueNotifier({});

  ValueNotifier<bool> get submitting => _submitting;

  bool get isSubmitting => _submitting.value;

  void setSubmitting(bool submitting) {
    _submitting.value = submitting;
  }

  void register(String name, dynamic initialValue,
      [List<LsdAction>? validations]) {
    if (!values.containsKey(name)) {
      values[name] = initialValue;
    }

    this.validations[name] = LsdFormValidator(validations ?? []);
  }

  void unregister(String name) {
    if (values.containsKey(name)) {
      values.remove(name);
    }
  }

  void setValue(String key, dynamic value) {
    values[key] = value;
  }

  Future<bool> validate(
    BuildContext Function() getContext,
  ) async {
    this.errors.value = {};
    Map<String, String> errors = {};
    await Future.wait(validations.entries.toList().map((entry) async {
      final result =
          await entry.value.validate(getContext, values[entry.key] ?? "");
      if (!result.isValid) {
        errors[entry.key] = result.error!;
      }
    }));

    this.errors.value = errors;

    return errors.isEmpty;
  }
}
