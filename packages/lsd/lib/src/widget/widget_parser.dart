import '../lsd.dart';
import 'lsd_widget.dart';

abstract class LsdWidgetParser {
  late final Lsd lsd;

  /// Converts an [Map<String, dynamic>] into a flutter [SeViewWidget]
  LsdWidget fromJson(Map<String, dynamic> element);
}
