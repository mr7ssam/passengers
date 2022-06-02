import 'package:p_core/p_core.dart';
import 'package:p_network/p_refresh_token.dart';

import '../domain/entities/user.dart';
import '../domain/entities/user_profile.dart';
import 'facade.dart';

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
