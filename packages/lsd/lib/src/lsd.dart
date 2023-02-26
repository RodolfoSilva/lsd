import 'package:flutter/widgets.dart';

import 'action/action.dart';
import 'widget/widget.dart';

typedef ErrorWidgetBuilder = Widget Function(dynamic error);
typedef LoadingWidgetBuilder = Widget Function();

class Lsd {
  Lsd({
    required this.widgetParser,
    required this.actionParser,
    required this.buildLoadingWidget,
    required this.buildErrorWidget,
  }) {
    widgetParser.lsd = this;
    actionParser.lsd = this;
  }

  final LsdWidgetParser widgetParser;
  final LsdActionParser actionParser;
  final LoadingWidgetBuilder buildLoadingWidget;
  final ErrorWidgetBuilder buildErrorWidget;

  LsdWidget parseWidget(Map<String, dynamic> element) =>
      widgetParser.fromJson(element);

  LsdWidget? parseWidgetOrNull(dynamic element) {
    if (element == null) return null;
    return parseWidget(element);
  }

  bool isWidget(dynamic element) => widgetParser.isWidget(element);

  LsdAction parseAction(Map<String, dynamic> element) =>
      actionParser.fromJson(element);

  LsdAction? parseActionOrNull(dynamic element) {
    if (element == null) return null;
    return parseAction(element);
  }

  bool isAction(dynamic element) => actionParser.isAction(element);

  Widget renderLoading(BuildContext context) => buildLoadingWidget();

  Widget renderError(BuildContext context, dynamic error) =>
      buildErrorWidget(error);
}
