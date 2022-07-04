import 'ser_view.dart';
import 'ser_view_widget.dart';

abstract class SerViewElementParser {
  late final SerView serView;

  /// Converts an [Map<String, dynamic>] into a flutter [SeViewWidget]
  SerViewWidget fromJson(Map<String, dynamic> element);
}
