import 'package:p_core/p_core.dart';
import 'package:p_network/p_refresh_token.dart';

import '../domain/entities/user.dart';
import '../domain/entities/user_info.dart';
import '../domain/entities/user_profile.dart';
import '../domain/repositories/repo.dart';

class UserFacade {
  final IUserRepo _userRepo;

  UserFacade({
    required IUserRepo userRepo,
  }) : _userRepo = userRepo;

  Future<ApiResult<User>> login(Params params) {
    return toApiResult(
      () => _userRepo.login(params),
    );
  }

  Future<ApiResult<User>> skip() {
    return toApiResult(
      () => _userRepo.skip(),
    );
  }

  Future<ApiResult<void>> signUp(Params params) {
    return toApiResult(
      () async {
        await _userRepo.signUp(params);
        await _userRepo.login(params);
      },
    );
  }

  Future<ApiResult<UserProfile>> getProfile() {
    return toApiResult(
      () => _userRepo.getProfile(),
    );
  }

  Future<ApiResult<UserInfo>> getInfo() {
    return toApiResult(
      () => _userRepo.getInfo(),
    );
  }

  Future<ApiResult<UserInfo>> updateInfo(Params params) {
    return toApiResult(
      () => _userRepo.updateInfo(params),
    );
  }

  Future<void> updateImage(FormDataParams params) {
    return _userRepo.updateImage(params);
  }

  Future<void> logout() {
    return _userRepo.logout();
  }

  Stream<User?> get userStream => _userRepo.userStream;

  Stream<AuthStatus> get authStream => _userRepo.authStream;

  User? get user => _userRepo.user;
}
