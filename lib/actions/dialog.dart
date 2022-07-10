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
  Future<dynamic> perform(
    BuildContext Function() getContext,
    dynamic params,
  ) async {
    final result = await showDialog<String?>(
      context: getContext(),
      builder: (BuildContext context) => AlertDialog(
        title: title.toWidth(context),
        content: content.toWidth(context),
        actions: actions.map((e) => e.toWidth(context)).toList(),
      ),
    );

    debugPrint(jsonEncode({"result": result}));
    return {"result": result};
  }
}
