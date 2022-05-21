import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/app/user/data/local/data_sources/token_storage.dart';
import 'package:shop_app/app/user/data/local/data_sources/user_storage.dart';
import 'package:shop_app/app/user/data/local/models/token.dart';
import 'package:shop_app/app/user/data/remote/remote.dart';
import 'package:shop_app/app/user/domain/entities/user_info.dart';
import 'package:shop_app/app/user/domain/entities/user_profile.dart';
import 'package:shop_app/app/user/domain/entities/working_model.dart';
import 'package:shop_app/app/user/domain/repositories/repo.dart';
import 'package:shop_app/core/remote/params.dart';

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
  Future<User> login(Params params) async {
    final userDTO = await _remote.login(params);
    final user = userDTO.toModel();
    await _userStorage.write(user);
    await _tokenStorage.write(AuthTokenModel.fromMap(userDTO.tokenMap()));
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
  Future<WorkingModel> getWorking() {
    return _remote.getWorking().then(
          (value) => value.toModel(),
        );
  }

  @override
  Future<void> updateWorkHours(Params params) {
    return _remote.updateWorkHours(params);
  }

  @override
  Future<void> updateWorkDays(Params params) {
    return _remote.updateWorkDays(params);
  }

  @override
  Future<void> completeInformation(Params params) async {
    final result = await _remote.completeInformation(
      params as FormDataParams,
    );
    await _userStorage.write(
      user!.copyWith(
        imagePath: result.imagePath,
        accountStatus: AccountStatus.completed,
      ),
    );
    print('completeInformation');
    return;
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
        name: userInfo.name,
        categoryName: userInfo.category?.name,
      ),
    );
    return _remote.updateUserInfo(params).then(
          (value) => value.toModel(),
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
