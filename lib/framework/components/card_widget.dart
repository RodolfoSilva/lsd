import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class CardWidget extends LsdWidget {
  late LsdWidget child;

  CardWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: child.toWidget(context),
    );
  }
}
