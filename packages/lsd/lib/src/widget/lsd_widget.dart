import 'package:flutter/widgets.dart' show Widget, BuildContext;

import '../lsd.dart';

class LsdWidget {
  const LsdWidget(this.lsd);

  final Lsd lsd;

  LsdWidget fromJson(Map<String, dynamic> props) {
    return this;
  }

  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
