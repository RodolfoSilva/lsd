import 'package:flutter/widgets.dart';

import 'action/action.dart';
import 'widget/widget.dart';

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
  final Widget Function() buildLoadingWidget;
  final Widget Function() buildErrorWidget;

  LsdWidget parseWidget(Map<String, dynamic> element) =>
      widgetParser.fromJson(element);

  LsdAction parseAction(Map<String, dynamic> element) =>
      actionParser.fromJson(element);

  Widget renderLoading(BuildContext context) => buildLoadingWidget();

  Widget renderError(BuildContext context, dynamic error) => buildErrorWidget();
}
