import '../lsd.dart';
import 'lsd_widget.dart';

abstract class LsdWidgetParser {
  late final Lsd lsd;

  /// Converts an [Map<String, dynamic>] into a [LsdWidget]
  LsdWidget fromJson(Map<String, dynamic> element);

  /// Check if an [dynamic] into a [LsdWidget] json
  bool isWidget(dynamic element);
}
