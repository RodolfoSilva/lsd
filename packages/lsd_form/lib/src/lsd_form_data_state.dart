import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_validator.dart';

class LsdFormDataState {
  final List<String> fields = [];
  final Map<String, LsdFormValidator> validations = {};
  final Map<String, String?> values = {};
  final ValueNotifier<bool> _submitting = ValueNotifier(false);
  final ValueNotifier<Map<String, String>> errors = ValueNotifier({});

  ValueNotifier<bool> get submitting => _submitting;

  bool get isSubmitting => _submitting.value;

  void setSubmitting(bool submitting) {
    _submitting.value = submitting;
  }

  void register(String name, String? initialValue,
      [List<LsdAction>? validations]) {
    if (!fields.contains(name)) {
      fields.add(name);
      values[name] = initialValue;
    }

    this.validations[name] = LsdFormValidator(validations ?? []);
  }

  void unregister(String name) {
    if (fields.contains(name)) {
      fields.removeWhere((n) => n == name);
    }
  }

  void setValue(String key, String? value) {
    values[key] = value;
  }
}
