import 'package:p_core/p_core.dart';
import 'package:p_network/p_refresh_token.dart';

import '../../domain/entities/token.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_info.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/repo.dart';
import '../local/data_sources/token_storage.dart';
import '../local/data_sources/user_storage.dart';
import '../remote/remote.dart';

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
  Future<User> login(Params params) async {
    final userDTO = await _remote.login(params);
    final user = userDTO.toModel();
    await _userStorage.write(user);
    await _tokenStorage.write(AuthTokenModel.fromMap(user.tokenMap()));
    return user;
  }

  @override
  Future<User> skip() async {
    final User user = User.guest();
    await _userStorage.write(user);
    await _tokenStorage.write(AuthTokenModel.fromMap(user.tokenMap()));
    return user;
  }

  @override
  Future<void> signUp(Params params) {
    return _remote.signUp(params);
  }

  @override
  Future<UserProfile> getProfile() {
    return _remote
        .getUserProfile()
        .then((value) => value.toModel(userId: user!.id));
  }

  @override
  Future<UserInfo> getInfo() {
    return _remote.getUserInfo().then((value) => value.toModel());
  }

  @override
  Future<UserInfo> updateInfo(Params params) {
    final userInfo = params as UserInfo;
    _userStorage.write(
      user!.copyWith(
        fullName: userInfo.fullName,
      ),
    );
    return _remote.updateUserInfo(params).then(
          (value) => userInfo,
        );
  }

  @override
  Future<void> updateImage(FormDataParams params) async {
    final updateImage = await _remote.updateImage(params);
    _userStorage.write(
      user!.copyWith(imagePath: updateImage),
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
