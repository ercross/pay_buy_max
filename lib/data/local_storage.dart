import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // create a singleton of LocalStorage
  static final LocalStorage _localStorage = LocalStorage._storage();
  factory LocalStorage() => _localStorage;
  LocalStorage._storage();

  static late SharedPreferences _prefs;

  /// loadPreferences loads local variable _prefs.
  /// This ensures almost instantaneous access to the
  /// sharedPreferences instances,
  /// which is usually read from disk and might be slow
  static Future<void> loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void clearStorage() async {
    await _prefs.clear();
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> saveString({required String key, required String value}) async {
    return await _prefs.setString(key, value);
  }
}

/// [StorageKey] holds key to any data stored into shared preferences
class StorageKey {
  static const String authToken = "auth_token";
}
