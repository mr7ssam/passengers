import 'package:p_network/p_http_client.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/core/params.dart';
import 'package:shop_app/features/user/domain/entities/user_info.dart';
import 'package:shop_app/features/user/domain/entities/user_profile.dart';

import '../entities/user.dart';

abstract class IUserRepo {
  Future<ApiResult<User>> login(Params params);
  Future<ApiResult<void>> signUp(Params params);
  Future<ApiResult<void>> completeInformation(Params params);
  Future<ApiResult<UserProfile>> getProfile();
  Future<ApiResult<UserInfo>> getInfo();
  Future<ApiResult<UserInfo>> updateInfo(Params params);
  Future<void> logout();
  Stream<User?> get userStream;
  User? get user;
  Stream<AuthStatus> get authStream;
}
