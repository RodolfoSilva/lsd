import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class DividerWidget extends LsdWidget {
  DividerWidget(super.lsd);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 1,
          color: Colors.grey[300]!,
        ),
      )),
    );
  }
}
