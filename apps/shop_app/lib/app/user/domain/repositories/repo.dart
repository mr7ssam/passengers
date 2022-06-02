import 'package:p_core/p_core.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/app/user/domain/entities/user_info.dart';
import 'package:shop_app/app/user/domain/entities/user_profile.dart';
import 'package:shop_app/app/user/domain/entities/working_model.dart';

import '../entities/user.dart';

abstract class IUserRepo {
  Future<User> login(Params params);

  Future<void> signUp(Params params);

  Future<void> completeInformation(Params params);

  Future<UserProfile> getProfile();

  Future<UserInfo> getInfo();

  Future<WorkingModel> getWorking();

  Future<UserInfo> updateInfo(Params params);

  Future<void> updateImage(FormDataParams params);

  Future<void> updateWorkHours(Params params);

  Future<void> updateWorkDays(Params params);

  Future<void> logout();

  Stream<User?> get userStream;

  User? get user;

  Stream<AuthStatus> get authStream;
}
