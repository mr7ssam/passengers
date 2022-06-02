import 'package:customer_app/common/const/const.dart';
import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';

import 'models/user_dto.dart';
import 'models/user_info_dto.dart';
import 'models/user_profile_dto.dart';

class UserRemote {
  final Dio _dio;

  UserRemote(this._dio);

  Future<UserDto> login(Params params) async {
    final result = await _dio.post(
      APIRoutes.user.login,
      data: params.toMap(),
      cancelToken: params.cancelToken,
    );
    return throwAppException(() => UserDto.fromAPI(result.data));
  }

  Future<void> signUp(Params params) async {
    await _dio.post(
      APIRoutes.user.signUp,
      data: params.toMap(),
      cancelToken: params.cancelToken,
    );
  }

  Future<UserProfileDTO> getUserProfile() async {
    return await _dio
        .get(
          APIRoutes.user.getProfile,
        )
        .then((value) =>
            throwAppException(() => UserProfileDTO.fromMap(value.data)));
  }

  Future<UserInfoDTO> getUserInfo() async {
    return await _dio
        .get(
          APIRoutes.user.getInfo,
        )
        .then((value) =>
            throwAppException(() => UserInfoDTO.fromMap(value.data)));
  }

  Future<bool> updateUserInfo(Params params) async {
    return await _dio
        .put(
          APIRoutes.user.updateInfo,
          data: params.toMap(),
        )
        .then((value) => throwAppException(() => true));
  }

  Future<String> updateImage(FormDataParams params) async {
    final formData = await params.toFromData();

    return await _dio
        .patch(
          APIRoutes.user.updateImage,
          data: formData,
        )
        .then((value) => value.data);
  }
}
