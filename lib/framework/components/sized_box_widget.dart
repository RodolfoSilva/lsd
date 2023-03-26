import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class SizedBoxWidget extends LsdWidget {
  SizedBoxWidget(super.lsd);

  late LsdWidget child;
  late double? height;
  late double? width;

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    height = double.tryParse(props["height"]?.toString() ?? "");
    width = double.tryParse(props["width"]?.toString() ?? "");
    child = lsd.parseWidget(props["child"]);
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: child.toWidget(context),
    );
  }
}
