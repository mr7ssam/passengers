import 'dart:async';
import 'dart:convert';

import 'package:p_network/p_refresh_token.dart';

import '../../../../../common/const/const.dart';
import '../../../../../core/storage/storage_service.dart';
import '../../../domain/entities/token.dart';

class TokenStorageImpl extends BotTokenStorage<AuthTokenModel>
    with RefreshBotMixin<AuthTokenModel> {
  final IStorageService storageService;

  TokenStorageImpl(this.storageService) : super();

  @override
  FutureOr<void> delete([String? message]) async {
    await storageService.remove(kTokenKey);
    super.delete(message);
  }

  @override
  FutureOr<void> write(AuthTokenModel? token) async {
    final data = token != null ? json.encode(token.toMap()) : null;
    await storageService.setString(kTokenKey, data);
    super.write(token);
  }

  @override
  AuthTokenModel? read() {
    final String? string = storageService.getString(kTokenKey);
    if (string != null) {
      return AuthTokenModel.fromMap(json.decode(string));
    }
    return null;
  }
}
