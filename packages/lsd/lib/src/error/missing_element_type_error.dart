import 'error.dart';

class LsdMissingElementTypeError implements LsdError {
  LsdMissingElementTypeError(this.message);

  @override
  String? message;

  @override
  String toString() {
    return "LsdMissingElementTypeError: $message";
  }
}
