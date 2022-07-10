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

    return Stack(
      children: [
        Scaffold(
          appBar: title,
          body: body != null
              ? Builder(builder: (context) => body!.toWidth(context))
              : null,
        ),
        // if (_isLoading)
        const Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        // if (_isLoading)
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
