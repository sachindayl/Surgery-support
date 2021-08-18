import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal();

  final prefs = SharedPreferences.getInstance();

  Future<bool?> getBoolean(String key) {
    return prefs.then((config) => config.getBool(key));
  }

  Future<void> setBoolean(String key, bool value) {
    return prefs.then((config) => config.setBool(key, value));
  }

  Future<String?> getString(String key) {
    return prefs.then((config) => config.getString(key));
  }

  Future<void> setString(String key, String value) {
    return prefs.then((config) => config.setString(key, value));
  }

  Future<int?> getInt(String key) {
    return prefs.then((config) => config.getInt(key));
  }

  Future<void> setInt(String key, int value) {
    return prefs.then((config) => config.setInt(key, value));
  }
}
