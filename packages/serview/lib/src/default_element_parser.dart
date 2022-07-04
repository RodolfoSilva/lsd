import 'ser_view.dart';
import 'ser_view_missing_element_type_error.dart';
import 'ser_view_parser.dart';
import 'ser_view_unknown_element_error.dart';
import 'ser_view_widget.dart';
import 'widgets_shelf.dart';

class DefaultSerViewElementParser implements SerViewElementParser {
  DefaultSerViewElementParser({
    required WidgetsShelf widgetsShelf,
  }) : _widgetsShelf = widgetsShelf;

  @override
  late final SerView serView;

  final WidgetsShelf _widgetsShelf;

  @override
  SerViewWidget fromJson(Map<String, dynamic> element) {
    if (!element.containsKey("type")) {
      throw SerViewMissingElementTypeError();
    }

    if (!_widgetsShelf.containsType(element["type"])) {
      throw SerViewUnknownElementError();
    }

    return _widgetsShelf
        .create(element["type"], serView)
        .fromJson(element["props"]);
  }
}
