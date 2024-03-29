import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class TextWidget extends LsdWidget {
  late String text;

  TextWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    text = props["text"];
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
