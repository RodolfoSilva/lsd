import 'storage.dart';

class Auth {
  Auth(this.storage);

  final Storage storage;
  final String _tokenKey = "token";

  Future<String?> getToken() async {
    return await storage.read(_tokenKey);
  }

  Future<void> setToken(String token) async {
    await storage.write(_tokenKey, token);
  }

  Future<void> removeToken() async {
    await storage.delete(_tokenKey);
  }
}
