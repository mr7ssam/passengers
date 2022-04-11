abstract class IStorageService {
  bool? getBool(String key);

  String? getString(String key);

  int? getInt(String key);

  Future<void> setBool(String key, bool? value);

  Future<void> setString(String key, String? value);

  Future<void> setInt(String key, int? value);

  Future<void> remove(String key);
}
