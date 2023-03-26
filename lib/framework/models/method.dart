enum Method {
  get("GET"),
  post("POST"),
  put("PUT"),
  delete("DELETE");

  final String _value;
  const Method(this._value);

  static Method fromString(String method) {
    final normalizedMethod = method.toUpperCase();

    if (normalizedMethod == Method.get._value) {
      return Method.get;
    } else if (normalizedMethod == Method.post._value) {
      return Method.post;
    } else if (normalizedMethod == Method.put._value) {
      return Method.put;
    } else if (normalizedMethod == Method.delete._value) {
      return Method.delete;
    }

    return Method.get;
  }

  @override
  String toString() => _value;
}
