import '../lsd.dart';
import 'lsd_action.dart';

abstract class LsdActionParser {
  late final Lsd lsd;

  /// Converts an [Map<String, dynamic>] into a [LsdAction]
  LsdAction fromJson(Map<String, dynamic> action);

  /// Check if an [dynamic] into a [LsdAction] json
  bool isAction(dynamic element);
}
