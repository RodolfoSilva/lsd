import '../lsd.dart';
import 'lsd_action.dart';

class LsdActionsShelf {
  final Map<String, LsdAction Function(Lsd lsd)> _knowActions = {};
  final Map<String, LsdAction> _loadedInstances = {};

  register(String type, LsdAction Function(Lsd lsd) getInstance) {
    _knowActions[type.toLowerCase()] = getInstance;
  }

  bool containsType(String type) {
    return _knowActions.containsKey(type.toLowerCase());
  }

  LsdAction create(String type, Lsd lsd) {
    if (!_loadedInstances.containsKey(type.toLowerCase())) {
      return _knowActions[type.toLowerCase()]!.call(lsd);
    }

    throw UnsupportedError("Unknown `$type` action");
  }
}
