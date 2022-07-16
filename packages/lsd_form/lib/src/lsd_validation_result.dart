class LsdValidationResult {
  final bool isValid;
  final String? error;

  LsdValidationResult._(this.isValid, this.error);

  factory LsdValidationResult.valid() {
    return LsdValidationResult._(true, null);
  }

  factory LsdValidationResult.invalid(String error) {
    return LsdValidationResult._(false, error);
  }
}
