import 'package:p_core/p_core.dart';
import 'package:p_network/p_refresh_token.dart';

import '../entities/user.dart';
import '../entities/user_info.dart';
import '../entities/user_profile.dart';

abstract class IUserRepo {
  Future<User> login(Params params);

  Future<User> skip();

  Future<void> signUp(Params params);

  Future<UserProfile> getProfile();

  Future<UserInfo> getInfo();

  Future<UserInfo> updateInfo(Params params);

  Future<void> updateImage(FormDataParams params);

  Future<void> logout();

  Stream<User?> get userStream;

  User? get user;

  Stream<AuthStatus> get authStream;
}
