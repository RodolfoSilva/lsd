import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ColumnWidget extends LsdWidget {
  late final bool fullWidth;
  late final List<LsdWidget> children;
  late final CrossAxisAlignment crossAxisAlignment;
  late final MainAxisAlignment mainAxisAlignment;
  late final MainAxisSize mainAxisSize;

  ColumnWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    fullWidth = props["full_width"] == true;
    mainAxisSize = getMainAxisSize(props["main_axis_size"]);
    crossAxisAlignment = getCrossAlignment(props["cross_alignment"]);
    mainAxisAlignment = getMainAlignment(props["main_alignment"]);
    children = List<Map<String, dynamic>>.from(props["children"])
        .map((element) => lsd.parseWidget(element))
        .toList();

    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final children =
        this.children.map((element) => element.toWidget(context)).toList();

    if (fullWidth) {
      children.add(const SizedBox(width: double.infinity));
    }

    return Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}

MainAxisSize getMainAxisSize(String? axisSize) {
  switch (axisSize) {
    case 'min':
      return MainAxisSize.min;
    case 'max':
      return MainAxisSize.max;
    default:
      return MainAxisSize.max;
  }
}

MainAxisAlignment getMainAlignment(String? alignment) {
  switch (alignment) {
    case 'start':
      return MainAxisAlignment.start;
    case 'end':
      return MainAxisAlignment.end;
    case 'center':
      return MainAxisAlignment.center;
    case 'spaceBetween':
      return MainAxisAlignment.spaceBetween;
    case 'spaceAround':
      return MainAxisAlignment.spaceAround;
    case 'spaceEvenly':
      return MainAxisAlignment.spaceEvenly;
    default:
      return MainAxisAlignment.start;
  }
}

CrossAxisAlignment getCrossAlignment(String? alignment) {
  switch (alignment) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'center':
      return CrossAxisAlignment.center;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    case 'baseline':
      return CrossAxisAlignment.baseline;
    default:
      return CrossAxisAlignment.center;
  }
}
