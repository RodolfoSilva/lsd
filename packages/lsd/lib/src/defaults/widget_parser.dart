import '../error/error.dart';
import '../lsd.dart';
import '../widget/widget.dart';

class DefaultLsdWidgetParser implements LsdWidgetParser {
  DefaultLsdWidgetParser({
    required LsdWidgetsShelf widgetsShelf,
    String typeKey = "component",
    String propsKey = "props",
  })  : _widgetsShelf = widgetsShelf,
        _typeKey = typeKey,
        _propsKey = propsKey;

  @override
  late final Lsd lsd;

  final String _typeKey;
  final String _propsKey;
  final LsdWidgetsShelf _widgetsShelf;

  @override
  LsdWidget fromJson(Map<String, dynamic> element) {
    if (!element.containsKey(_typeKey)) {
      throw LsdMissingElementTypeError("Missing widget ${element[_typeKey]}");
    }

    if (!_widgetsShelf.containsType(element[_typeKey])) {
      throw LsdUnknownElementError("Unknown widget ${element[_typeKey]}");
    }

    return _widgetsShelf
        .create(element[_typeKey], lsd)
        .fromJson(element[_propsKey]);
  }

  @override
  bool isWidget(dynamic element) {
    return element is Map && element.containsKey(_typeKey);
  }
}
