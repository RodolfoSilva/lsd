import '../lsd.dart';
import 'lsd_widget.dart';

class LsdWidgetsShelf {
  final Map<String, LsdWidget Function(Lsd lsd)> _knowWidgets = {};
  final Map<String, LsdWidget> _loadedInstances = {};

  register(String type, LsdWidget Function(Lsd lsd) getInstance) {
    _knowWidgets[type.toLowerCase()] = getInstance;
  }

  bool containsType(String type) {
    return _knowWidgets.containsKey(type.toLowerCase());
  }

  LsdWidget create(String type, Lsd lsd) {
    if (!_loadedInstances.containsKey(type.toLowerCase())) {
      return _knowWidgets[type.toLowerCase()]!.call(lsd);
    }

    throw UnsupportedError("Unknown `$type` widget");
  }
}
