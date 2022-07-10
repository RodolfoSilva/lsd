import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ScreenWidget extends LsdWidget {
  late final String? title;
  late final LsdWidget? body;

  ScreenWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    title = props["title"];
    body = props["body"] != null ? lsd.parseWidget(props["body"]!) : null;

    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final title = this.title != null ? AppBar(title: Text(this.title!)) : null;

    return Scaffold(
      appBar: title,
      body: body != null
          ? Builder(builder: (context) => body!.toWidth(context))
          : null,
    );
  }
}
