import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class CenterWidget extends LsdWidget {
  late LsdWidget child;

  CenterWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child.toWidget(context),
    );
  }
}
