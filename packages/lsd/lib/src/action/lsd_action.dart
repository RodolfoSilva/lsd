import 'package:flutter/widgets.dart' show BuildContext;

import '../lsd.dart';

class LsdAction {
  const LsdAction(this.lsd);

  final Lsd lsd;

  LsdAction fromJson(Map<String, dynamic> props) {
    return this;
  }

  Map<String, dynamic>? perform(
    BuildContext context,
    Map<String, dynamic>? initialResult,
  ) {
    throw UnimplementedError();
  }
}
