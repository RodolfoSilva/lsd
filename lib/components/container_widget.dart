import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ContainerWidget extends LsdWidget {
  late LsdWidget child;
  late int padding;

  ContainerWidget(super.serView);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    padding = props["padding"] ?? 0;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding.toDouble()),
      child: Builder(builder: (context) => child.build(context)),
    );
  }
}
