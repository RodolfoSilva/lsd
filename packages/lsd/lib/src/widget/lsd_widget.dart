import 'package:flutter/widgets.dart' show Widget, BuildContext;

import '../lsd.dart';

abstract class LsdWidget {
  LsdWidget(this.lsd);

  final Lsd lsd;
  late BuildContext context;

  BuildContext getContext() => context;

  LsdWidget fromJson(Map<String, dynamic> props) {
    return this;
  }

  Widget toWidget(BuildContext context) {
    this.context = context;
    return build(context);
  }

  Widget build(BuildContext context);
}
