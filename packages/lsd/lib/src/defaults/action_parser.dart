import '../action/action.dart';
import '../error/error.dart';
import '../lsd.dart';

class DefaultLsdActionParser implements LsdActionParser {
  DefaultLsdActionParser({
    required LsdActionsShelf actionsShelf,
    String typeKey = "action",
    String propsKey = "props",
  })  : _actionsShelf = actionsShelf,
        _typeKey = typeKey,
        _propsKey = propsKey;

  @override
  late final Lsd lsd;

  final String _typeKey;
  final String _propsKey;
  final LsdActionsShelf _actionsShelf;

  @override
  LsdAction fromJson(Map<String, dynamic> element) {
    if (!element.containsKey(_typeKey)) {
      throw LsdMissingElementTypeError("Missing action ${element[_typeKey]}");
    }

    if (!_actionsShelf.containsType(element[_typeKey])) {
      throw LsdUnknownElementError("Unknown action ${element[_typeKey]}");
    }

    return _actionsShelf
        .create(element[_typeKey], lsd)
        .fromJson(element[_propsKey]);
  }

  @override
  bool isAction(dynamic element) {
    return element is Map && element.containsKey(_typeKey);
  }
}
