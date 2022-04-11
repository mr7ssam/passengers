import 'package:p_network/p_http_client.dart';
import 'package:shop_app/features/user/application/facade.dart';
import 'package:shop_app/features/user/domain/entities/user_profile.dart';

class UserAPI {
  final UserFacade _userFacade;

  UserAPI(this._userFacade);

  Future<ApiResult<UserProfile>> getProfile() {
    return _userFacade.getProfile();
  }
}
