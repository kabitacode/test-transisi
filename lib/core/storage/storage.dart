import 'package:mmkv/mmkv.dart';

class Storage {
  static final MMKV _storage = MMKV.defaultMMKV();

  static const _tokenKey = 'TOKEN';

  static Future<void> saveToken(String token) async {
    _storage.encodeString(_tokenKey, token);
  }

  static String? getToken() {
    return _storage.decodeString(_tokenKey);
  }

  static void clearSession() {
    _storage.removeValue(_tokenKey);
  }

  static bool isLoggedIn() {
    return getToken() != null;
  }
}
