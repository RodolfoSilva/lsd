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

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static LsdFormDataState of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<LsdFormProvider>();
    assert(result != null, 'No FormWidget found in context');
    return result!._state;
  }
}
