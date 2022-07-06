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
      lsd: lsd,
      child: Builder(
        builder: (context) => child.build(context),
      ),
    );
  }
}

class ValidationResult {
  final bool isValid;
  final String? error;

  ValidationResult._(this.isValid, this.error);

  factory ValidationResult.valid() {
    return ValidationResult._(true, null);
  }

  factory ValidationResult.invalid(String error) {
    return ValidationResult._(false, error);
  }
}

class Validator {
  Validator(this.validations);

  final List<LsdAction> validations;

  Future<ValidationResult> validate(BuildContext context, String value) async {
    for (final validation in validations) {
      final result = await validation.perform(context, value);

      if (result is ValidationResult) {
        return result;
      }

      if (result != null && !!result) {
        return ValidationResult.valid();
      } else {
        return ValidationResult.invalid("Unknown error");
      }
    }

    return ValidationResult.valid();
  }
}

class FormDataWidget extends InheritedWidget {
  FormDataWidget({
    Key? key,
    required Lsd lsd,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  final List<String> fields = [];
  final Map<String, Validator> validations = {};
  final Map<String, String?> _values = {};
  final ValueNotifier<Map<String, String>> _errors = ValueNotifier({});

  ValueNotifier<Map<String, String>> get errors => _errors;

  void register(String name, [List<LsdAction>? validations]) {
    if (!fields.contains(name)) {
      fields.add(name);
    }

    this.validations[name] = Validator(validations ?? []);
  }

  void unregister(String name) {
    if (fields.contains(name)) {
      fields.removeWhere((n) => n == name);
    }
  }

  void setValue(String key, String? value) {
    _values[key] = value;
  }

  Future validate(BuildContext context) async {
    _errors.value = {};
    Map<String, String> errors = {};
    await Future.wait(validations.entries.toList().map((entry) async {
      final result =
          await entry.value.validate(context, _values[entry.key] ?? "");
      if (!result.isValid) {
        errors[entry.key] = result.error!;
      }
    }));

    _errors.value = errors;

    return errors.isEmpty;
  }

  static FormDataWidget of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FormDataWidget>();
    assert(result != null, 'No FormWidget found in context');
    return result!;
  }
}
