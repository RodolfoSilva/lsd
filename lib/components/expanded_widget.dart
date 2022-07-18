import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ExpandedWidget extends LsdWidget {
  late LsdWidget child;
  late int padding;

  ExpandedWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    padding = props["padding"] ?? 0;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: child.toWidget(context),
    );
  }
}
