import '../action/action.dart';
import '../error/error.dart';
import '../lsd.dart';

class DefaultLsdActionParser implements LsdActionParser {
  DefaultLsdActionParser({
    required LsdActionsShelf actionsShelf,
  }) : _actionsShelf = actionsShelf;

  @override
  late final Lsd lsd;

  final LsdActionsShelf _actionsShelf;

  @override
  LsdAction fromJson(Map<String, dynamic> element) {
    if (!element.containsKey("type")) {
      throw LsdMissingElementTypeError("Missing action ${element["type"]}");
    }

    if (!_actionsShelf.containsType(element["type"])) {
      throw LsdUnknownElementError("Unknown action ${element["type"]}");
    }

    return _actionsShelf
        .create(element["type"], lsd)
        .fromJson(element["props"]);
  }
}
