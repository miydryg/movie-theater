import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static const String key = 'accessToken';

  static Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}