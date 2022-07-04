import 'package:flutter/widgets.dart';

import 'ser_view_parser.dart';
import 'ser_view_widget.dart';

class SerView {
  SerView({
    required this.parser,
    required this.buildLoadingWidget,
    required this.buildErrorWidget,
  }) {
    parser.serView = this;
  }

  final SerViewElementParser parser;
  final Widget Function() buildLoadingWidget;
  final Widget Function() buildErrorWidget;

  SerViewWidget parse(Map<String, dynamic> element) => parser.fromJson(element);

  Widget renderLoading(BuildContext context) => buildLoadingWidget();

  Widget renderError(BuildContext context, dynamic error) => buildErrorWidget();
}
