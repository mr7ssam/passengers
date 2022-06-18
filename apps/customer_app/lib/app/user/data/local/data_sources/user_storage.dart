import 'dart:async';
import 'dart:convert';

import '../../../../../common/const/const.dart';
import '../../../../../core/storage/storage_service.dart';
import '../../../domain/entities/user.dart';
import 'package:bot_storage/bot_storage.dart';

class UserStorage extends BotStorage<User> with BotStorageMixin<User> {
  final IStorageService storageService;

  UserStorage(this.storageService) : super();

  @override
  FutureOr<void> delete() async {
    super.delete();
    await storageService.remove(kUserKey);
  }

  @override
  FutureOr<void> write(User? value) async {
    super.write(value);
    final data = value != null ? json.encode(value.toMap()) : null;
    await storageService.setString(
      kUserKey,
      data,
    );
  }

  @override
  User? read() {
    final String? string = storageService.getString(kUserKey);
    if (string != null) {
      return User.fromMap(json.decode(string));
    }
    return null;
  }
}
