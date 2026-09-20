import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage;
  SecureStorage(this.storage);

  Future<void> saveAccessToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<void> saveRefreshToken(String token) async {
    await storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refresh_token');
  }
  
}
