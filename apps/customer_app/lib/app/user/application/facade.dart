import 'package:customer_app/app/user/domain/repositories/address_repo.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_refresh_token.dart';

import '../domain/entities/address.dart';
import '../domain/entities/user.dart';
import '../domain/entities/user_info.dart';
import '../domain/entities/user_profile.dart';
import '../domain/repositories/repo.dart';

class UserFacade {
  final IUserRepo _userRepo;
  final IAddressRepo _addressRepo;

  UserFacade({
    required IUserRepo userRepo,
    required IAddressRepo addressRepo,
  })  : _userRepo = userRepo,
        _addressRepo = addressRepo;

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

  Future<ApiResult<List<Address>>> getAllAddress() {
    return toApiResult(() => _addressRepo.getAll());
  }

  Future<ApiResult<Address>> addAddress(Params params) {
    return toApiResult(
      () => _addressRepo.add(params),
    );
  }

  Future<ApiResult<Address>> updateAddress(Params params) {
    return toApiResult(
      () => _addressRepo.update(params),
    );
  }

  Future<ApiResult> deleteAddress(Address address) {
    return toApiResult(
      () => _addressRepo.delete(address),
    );
  }

  Stream<User?> get userStream => _userRepo.userStream;
  Stream<List<Address>?> get addressStream => _addressRepo.stream();

  Stream<AuthStatus> get authStream => _userRepo.authStream;

  User? get user => _userRepo.user;
}
