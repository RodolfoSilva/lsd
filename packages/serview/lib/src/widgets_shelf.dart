import 'ser_view.dart';
import 'ser_view_widget.dart';

class WidgetsShelf {
  final Map<String, SerViewWidget Function(SerView serView)> _knowWidgets = {};
  final Map<String, SerViewWidget> _loadedInstances = {};

  register(String type, SerViewWidget Function(SerView serView) getInstance) {
    _knowWidgets[type.toLowerCase()] = getInstance;
  }

  bool containsType(String type) {
    return _knowWidgets.containsKey(type.toLowerCase());
  }

  SerViewWidget create(String type, SerView serView) {
    if (!_loadedInstances.containsKey(type.toLowerCase())) {
      return _knowWidgets[type.toLowerCase()]!.call(serView);
    }

    throw UnsupportedError("Unknown `$type` widget");
  }
}
