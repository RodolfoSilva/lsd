import 'package:flutter/widgets.dart' show BuildContext;

import '../lsd.dart';

typedef GetContext = BuildContext Function();

class LsdAction {
  const LsdAction(this.lsd);

  final Lsd lsd;

  LsdAction fromJson(Map<String, dynamic> props) {
    return this;
  }

  Future<dynamic> perform(GetContext getContext, dynamic params) {
    throw UnimplementedError();
  }
}
