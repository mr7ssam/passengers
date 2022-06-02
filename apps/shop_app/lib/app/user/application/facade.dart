import 'package:p_core/p_core.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/app/user/domain/entities/user.dart';
import 'package:shop_app/app/user/domain/entities/user_info.dart';
import 'package:shop_app/app/user/domain/entities/user_profile.dart';
import 'package:shop_app/app/user/domain/entities/working_model.dart';
import 'package:shop_app/app/user/domain/repositories/repo.dart';

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

  Future<ApiResult<void>> signUp(Params params) {
    return toApiResult(
      () async {
        await _userRepo.signUp(params);
        await _userRepo.login(params);
      },
    );
  }

  Future<ApiResult<void>> completeInformation(Params params) {
    return toApiResult(
      () => _userRepo.completeInformation(params),
    );
  }

  Future<ApiResult<UserProfile>> getProfile() {
    return toApiResult(
      () => _userRepo.getProfile(),
    );
  }

  Future<ApiResult<WorkingModel>> getWorking() {
    return toApiResult(
      () => _userRepo.getWorking(),
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

  Future<ApiResult<void>> updateWorkDays(Params params) {
    return toApiResult(
      () => _userRepo.updateWorkDays(params),
    );
  }

  Future<ApiResult<void>> updateWorkHours(Params params) {
    return toApiResult(
      () => _userRepo.updateWorkHours(params),
    );
  }

  Future<ApiResult<void>> updateWorkDaysAndHours({
    required Params days,
    required Params hours,
  }) {
    return toApiResult(
      () async {
        await Future.wait(
            [_userRepo.updateWorkHours(hours), _userRepo.updateWorkDays(days)]);
      },
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
