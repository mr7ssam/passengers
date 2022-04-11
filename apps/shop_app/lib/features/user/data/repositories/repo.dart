import 'package:p_network/p_http_client.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/core/api_utils.dart';
import 'package:shop_app/core/params.dart';
import 'package:shop_app/features/user/data/local/data_sources/token_storage.dart';
import 'package:shop_app/features/user/data/local/data_sources/user_storage.dart';
import 'package:shop_app/features/user/data/local/models/token.dart';
import 'package:shop_app/features/user/data/remote/remote.dart';
import 'package:shop_app/features/user/domain/entities/user_info.dart';
import 'package:shop_app/features/user/domain/entities/user_profile.dart';
import 'package:shop_app/features/user/domain/repositories/repo.dart';

import '../../domain/entities/user.dart';

class UserRepo implements IUserRepo {
  final UserRemote _remote;
  final TokenStorageImpl _tokenStorage;
  final UserStorage _userStorage;

  UserRepo({
    required UserRemote remote,
    required TokenStorageImpl tokenStorage,
    required UserStorage userStorage,
  })  : _remote = remote,
        _tokenStorage = tokenStorage,
        _userStorage = userStorage;

  @override
  Future<ApiResult<User>> login(Params params) async {
    return toApiResult(
      () async {
        final userDTO = await _remote.login(params);
        final user = userDTO.toModel();
        await _userStorage.write(user);
        await _tokenStorage.write(AuthTokenModel.fromMap(userDTO.tokenMap()));
        return user;
      },
    );
  }

  @override
  Future<ApiResult<void>> signUp(Params params) {
    return toApiResult<void>(
      () async {
        await _remote.signUp(params);
      },
    );
  }

  @override
  Future<ApiResult<UserProfile>> getProfile() {
    return toApiResult<UserProfile>(
      () async {
        return _remote
            .getUserProfile()
            .then((value) => value.toModel(userId: user!.id));
      },
    );
  }

  @override
  Future<ApiResult<void>> completeInformation(Params params) {
    return toApiResult<void>(
      () async {
        final result = await _remote.completeInformation(
          params as FromDataParams,
        );
        await _userStorage.write(
          user!.copyWith(
            imagePath: result.imagePath,
            accountStatus: AccountStatus.completed,
          ),
        );
      },
    );
  }

  @override
  Future<ApiResult<UserInfo>> getInfo() {
    return toApiResult(
      () => _remote.getUserInfo().then(
            (value) => value.toModel(),
          ),
    );
  }

  @override
  Future<ApiResult<UserInfo>> updateInfo(Params params) {
    return toApiResult(
      () => _remote.updateUserInfo(params).then(
            (value) => value.toModel(),
          ),
    );
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.delete(null);
    await _userStorage.delete();
  }

  @override
  Stream<User?> get userStream => _userStorage.stream;

  @override
  Stream<AuthStatus> get authStream => _tokenStorage.authenticationStatus;

  @override
  User? get user => _userStorage.read();
}
