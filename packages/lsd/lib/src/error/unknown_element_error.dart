import 'error.dart';

class LsdUnknownElementError implements LsdError {
  LsdUnknownElementError(this.message);

  @override
  String? message;

  @override
  String toString() {
    return "LsdUnknownElementError: $message";
  }
}
