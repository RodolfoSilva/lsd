import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class RowWidget extends LsdWidget {
  late final List<LsdWidget> children;

  RowWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    children = List<Map<String, dynamic>>.from(props["children"])
        .map((element) => lsd.parseWidget(element))
        .toList();

    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children.map((e) => e.toWidget(context)).toList(),
    );
  }
}
