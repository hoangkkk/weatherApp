import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _localStorage;
  static SharedPreferences? _preferences;

  static Future<LocalStorageService?> getInstance() async {
    if (_localStorage == null) {
      var secureStorage = LocalStorageService._();
      await secureStorage._init();
      _localStorage = secureStorage;
    }
    return _localStorage;
  }

  /// Call only local in class
  LocalStorageService._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Get String from local
  static String getString(String key, {String defaultValue = ''}) {
    if (_preferences == null) return defaultValue;
    return _preferences?.getString(key) ?? defaultValue;
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    if (_preferences == null) return defaultValue;
    return _preferences?.getBool(key) ?? defaultValue;
  }

  /// Set String to local
  static Future<bool>? setString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences?.setString(key, value);
  }

  static Future<bool>? setBool(String key, bool value) {
    if (_preferences == null) return null;
    return _preferences?.setBool(key, value);
  }

  /// Get array to local

  static List<String> getStringList(String key) {
    if (_preferences == null) return [];
    return _preferences?.getStringList(key) ?? [];
  }

  /// Set array to local
  static Future<bool>? setListString(String key, List<String> value) {
    if (_preferences == null) return null;
    return _preferences?.setStringList(key, value);
  }

  static Future<bool?> removeStore(String key) async {
    if (_preferences == null) return null;
    return await _preferences?.remove(key);
  }

  static Future<bool> clearCache() async {
    return await _preferences?.clear() ?? false ;
  }
}
