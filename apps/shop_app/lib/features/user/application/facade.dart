import 'package:p_network/p_http_client.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/core/params.dart';
import 'package:shop_app/features/user/domain/entities/user.dart';
import 'package:shop_app/features/user/domain/entities/user_info.dart';
import 'package:shop_app/features/user/domain/entities/user_profile.dart';
import 'package:shop_app/features/user/domain/repositories/repo.dart';

class UserFacade {
  final IUserRepo _userRepo;

  UserFacade({
    required IUserRepo userRepo,
  }) : _userRepo = userRepo;

  Future<ApiResult<User>> login(Params params) {
    return _userRepo.login(params);
  }

  Future<ApiResult<void>> signUp(Params params) {
    return _userRepo.signUp(params);
  }

  Future<ApiResult<void>> completeInformation(Params params) {
    return _userRepo.completeInformation(params);
  }

  Future<ApiResult<UserProfile>> getProfile() {
    return _userRepo.getProfile();
  }

  Future<ApiResult<UserInfo>> getInfo() {
    return _userRepo.getInfo();
  }

  Future<ApiResult<UserInfo>> updateInfo(Params params) {
    return _userRepo.updateInfo(params);
  }


  Future<void> logout() {
    return _userRepo.logout();
  }

  Stream<User?> get userStream => _userRepo.userStream;

  Stream<AuthStatus> get authStream => _userRepo.authStream;

  User? get user => _userRepo.user;
}
