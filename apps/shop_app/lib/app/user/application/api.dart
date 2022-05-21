import 'package:p_network/api_result.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/app/user/application/facade.dart';
import 'package:shop_app/app/user/domain/entities/user_profile.dart';
import 'package:shop_app/core/remote/params.dart';

import '../domain/entities/user.dart';

class UserAPI {
  final UserFacade _userFacade;

  UserAPI(this._userFacade);

  Future<ApiResult<UserProfile>> getProfile() {
    return _userFacade.getProfile();
  }

  Future<void> updateImage(FormDataParams params) {
    return _userFacade.updateImage(params);
  }

  Stream<User?> get userStream => _userFacade.userStream;

  Stream<AuthStatus> get authStream => _userFacade.authStream;

  User? get user => _userFacade.user;
}
