abstract class Storage {
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
  Future<void> write(String key, String value);
}
