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
    return _FormWidget(
      lsd: lsd,
      child: child,
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({
    Key? key,
    required this.lsd,
    required this.child,
  }) : super(key: key);

  final Lsd lsd;
  final LsdWidget child;

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  late FormDataState _formDataState;
  @override
  void initState() {
    super.initState();

    _formDataState = FormDataState();
  }

  @override
  Widget build(BuildContext context) {
    return FormDataWidget(
      lsd: widget.lsd,
      formState: _formDataState,
      child: Builder(
        builder: (context) => widget.child.build(context),
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

class FormDataState {
  final List<String> fields = [];
  final Map<String, Validator> validations = {};
  final Map<String, String?> values = {};
  final ValueNotifier<Map<String, String>> errors = ValueNotifier({});

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
    values[key] = value;
  }
}

class FormDataWidget extends InheritedWidget {
  const FormDataWidget({
    Key? key,
    required Lsd lsd,
    required FormDataState formState,
    required Widget child,
  })  : _state = formState,
        super(key: key, child: child);

  final FormDataState _state;

  ValueNotifier<Map<String, String>> get errors => _state.errors;
  Map<String, String?> get values => _state.values;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  void register(String name, [List<LsdAction>? validations]) {
    _state.register(name, validations);
  }

  void unregister(String name) {
    _state.unregister(name);
  }

  void setValue(String key, String? value) {
    _state.setValue(key, value);
  }

  Future validate(BuildContext context) async {
    _state.errors.value = {};
    Map<String, String> errors = {};
    await Future.wait(_state.validations.entries.toList().map((entry) async {
      final result =
          await entry.value.validate(context, _state.values[entry.key] ?? "");
      if (!result.isValid) {
        errors[entry.key] = result.error!;
      }
    }));

    _state.errors.value = errors;

    return errors.isEmpty;
  }

  static FormDataWidget of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FormDataWidget>();
    assert(result != null, 'No FormWidget found in context');
    return result!;
  }
}
