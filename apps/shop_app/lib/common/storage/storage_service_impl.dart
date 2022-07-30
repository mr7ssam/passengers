import 'package:hive/hive.dart';

import 'storage_service.dart';

const kAppBoxKey = '__app_box__';

class StorageService implements IStorageService {
  final Box<dynamic>? _box;

  StorageService(Box<dynamic> box) : _box = box;

  @override
  bool? getBool(String key) {
    return _box!.get(key);
  }

  @override
  int? getInt(String key) {
    return _box!.get(key);
  }

  @override
  String? getString(String key) {
    return _box!.get(key);
  }

  @override
  Future setBool(String key, bool? value) async {
    if (value == null) {
      return remove(key);
    }
    return _box!.put(key, value);
  }

  @override
  Future setInt(String key, int? value) async {
    if (value == null) {
      return remove(key);
    }
    return _box!.put(key, value);
  }

  @override
  Future setString(String key, String? value) async {
    if (value == null) {
      return remove(key);
    }
    return _box!.put(key, value);
  }

  @override
  remove(String key) async {
    return _box!.delete(key);
  }
}
