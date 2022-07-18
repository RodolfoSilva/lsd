import 'package:shared_preferences/shared_preferences.dart';

import 'storage.dart';

class SharedStorage implements Storage {
  const SharedStorage(this._storage);

  final SharedPreferences _storage;

  @override
  Future<void> write(String key, String value) {
    return _storage.setString(key, value);
  }

  @override
  Future<String?> read(String key) async {
    return _storage.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.remove(key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.clear();
  }
}
