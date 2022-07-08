import 'error.dart';

class LsdBuildError implements LsdError {
  LsdBuildError(this.message);

  @override
  String? message;

  @override
  String toString() {
    return "LsdBuildError: $message";
  }
}
