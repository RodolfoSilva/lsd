import 'package:flutter/widgets.dart';

import 'widget/widget.dart';

class Lsd {
  Lsd({
    required this.parser,
    required this.buildLoadingWidget,
    required this.buildErrorWidget,
  }) {
    parser.lsd = this;
  }

  final LsdWidgetParser parser;
  final Widget Function() buildLoadingWidget;
  final Widget Function() buildErrorWidget;

  LsdWidget parse(Map<String, dynamic> element) => parser.fromJson(element);

  Widget renderLoading(BuildContext context) => buildLoadingWidget();

  Widget renderError(BuildContext context, dynamic error) => buildErrorWidget();
}
