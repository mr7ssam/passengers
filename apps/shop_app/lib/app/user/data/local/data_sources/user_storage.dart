import 'dart:async';
import 'dart:convert';

import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/app/user/domain/entities/user.dart';
import 'package:shop_app/common/const/const.dart';

import '../../../../../core/storage/storage_service.dart';

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
