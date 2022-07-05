import '../error/error.dart';
import '../lsd.dart';
import '../widget/widget.dart';

class DefaultLsdWidgetParser implements LsdWidgetParser {
  DefaultLsdWidgetParser({
    required LsdWidgetsShelf widgetsShelf,
  }) : _widgetsShelf = widgetsShelf;

  @override
  late final Lsd lsd;

  final LsdWidgetsShelf _widgetsShelf;

  @override
  LsdWidget fromJson(Map<String, dynamic> element) {
    if (!element.containsKey("type")) {
      throw LsdMissingElementTypeError("Missing widget ${element["type"]}");
    }

    if (!_widgetsShelf.containsType(element["type"])) {
      throw LsdUnknownElementError("Unknown widget ${element["type"]}");
    }

    return _widgetsShelf
        .create(element["type"], lsd)
        .fromJson(element["props"]);
  }
}