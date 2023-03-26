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
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    return showDialog<dynamic>(
      context: getContext(),
      barrierDismissible: false,
      builder: (dialogContext) {
        final context = getContext();
        return AlertDialog(
          title: title.toWidget(context),
          content: content.toWidget(context),
          actions: actions.map((e) => e.toWidget(context)).toList(),
        );
      },
    );
  }
}
