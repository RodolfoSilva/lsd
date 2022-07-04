import 'package:flutter/widgets.dart' show Widget, BuildContext;

import 'ser_view.dart';

class SerViewWidget {
  SerViewWidget(this.serView);

  final SerView serView;

  SerViewWidget fromJson(Map<String, dynamic> props) {
    return this;
  }

  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
