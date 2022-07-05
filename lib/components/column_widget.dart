import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ColumnWidget extends LsdWidget {
  late final bool fullWidth;
  late final List<LsdWidget> children;

  ColumnWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    fullWidth = props["fullWidth"] == true;
    children = List<Map<String, dynamic>>.from(props["children"])
        .map((element) => lsd.parseWidget(element))
        .toList();

    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final children =
        this.children.map((element) => element.build(context)).toList();

    if (fullWidth) {
      children.add(const SizedBox(width: double.infinity));
    }

    return Column(children: children);
  }
}
