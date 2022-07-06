import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ShowDialogAction extends LsdAction {
  ShowDialogAction(super.lsd);

  late LsdWidget title;
  late LsdWidget content;
  late List<LsdWidget> actions;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    title = lsd.parseWidget(props["title"]);
    content = lsd.parseWidget(props["content"]);

    actions = List<Map<String, dynamic>>.from(props["actions"])
        .map((e) => lsd.parseWidget(e))
        .toList();

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(BuildContext context, dynamic params) async {
    final result = await showDialog<String?>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: title.build(context),
        content: content.build(context),
        actions: actions.map((e) => e.build(context)).toList(),
      ),
    );

    debugPrint(jsonEncode({"result": result}));
    return {"result": result};
  }
}
