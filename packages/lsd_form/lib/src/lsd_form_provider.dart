import 'package:flutter/widgets.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_data_state.dart';

class LsdFormProvider extends InheritedWidget {
  const LsdFormProvider({
    Key? key,
    required Lsd lsd,
    required LsdFormDataState formState,
    required Widget child,
  })  : _state = formState,
        super(key: key, child: child);

  final LsdFormDataState _state;

  ValueNotifier<Map<String, String>> get errors => _state.errors;
  Map<String, String?> get values => _state.values;
  ValueNotifier<bool> get submitting => _state.submitting;
  bool get isSubmitting => _state.isSubmitting;

  void setSubmitting(bool submitting) {
    _state.setSubmitting(submitting);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  void register(String name, String? initialValue,
      [List<LsdAction>? validations]) {
    _state.register(name, initialValue, validations);
  }

  void unregister(String name) {
    _state.unregister(name);
  }

  void setValue(String key, String? value) {
    _state.setValue(key, value);
  }

  Future<bool> validate(
    BuildContext Function() getContext,
  ) async {
    _state.errors.value = {};
    Map<String, String> errors = {};
    await Future.wait(_state.validations.entries.toList().map((entry) async {
      final result = await entry.value
          .validate(getContext, _state.values[entry.key] ?? "");
      if (!result.isValid) {
        errors[entry.key] = result.error!;
      }
    }));

    _state.errors.value = errors;

    return errors.isEmpty;
  }

  static LsdFormProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<LsdFormProvider>();
    assert(result != null, 'No FormWidget found in context');
    return result!;
  }
}
