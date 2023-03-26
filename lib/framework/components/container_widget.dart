import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ContainerWidget extends LsdWidget {
  late LsdWidget? child;
  late EdgeInsetsGeometry? padding;
  late EdgeInsetsGeometry? margin;
  late LsdAction? onPress;

  ContainerWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = props["child"] != null ? lsd.parseWidget(props["child"]) : null;
    padding = parseSpace(props["padding"]?.toString());
    margin = parseSpace(props["margin"]?.toString());
    onPress =
        props["on_press"] != null ? lsd.parseAction(props["on_press"]) : null;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final container = Container(
      padding: padding,
      margin: margin,
      child: child?.toWidget(context),
    );

    if (onPress != null) {
      return Material(
        child: InkWell(
          onTap: () => onPress?.perform(getContext, null),
          child: Ink(child: container),
        ),
      );
    }

    return container;
  }
}

EdgeInsetsGeometry? parseSpace(String? space) {
  if (space == null) {
    return null;
  }

  final parts = space.split(' ');

  if (parts.length == 1) {
    return EdgeInsets.all(double.parse(parts[0]));
  } else if (parts.length == 2) {
    return EdgeInsets.symmetric(
      horizontal: double.parse(parts[1]),
      vertical: double.parse(parts[0]),
    );
  } else if (parts.length == 3) {
    return EdgeInsets.fromLTRB(
      double.parse(parts[1]),
      double.parse(parts[0]),
      double.parse(parts[1]),
      double.parse(parts[2]),
    );
  } else if (parts.length == 4) {
    return EdgeInsets.fromLTRB(
      double.parse(parts[1]),
      double.parse(parts[0]),
      double.parse(parts[3]),
      double.parse(parts[2]),
    );
  }

  return null;
}
