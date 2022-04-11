import 'package:p_network/p_http_client.dart';
import 'package:shop_app/common/const/const.dart';
import 'package:shop_app/core/api_utils.dart';
import 'package:shop_app/core/params.dart';
import 'package:shop_app/features/user/data/remote/models/complete_info.dart';
import 'package:shop_app/features/user/data/remote/models/user_dto.dart';
import 'package:shop_app/features/user/data/remote/models/user_profile_dto.dart';

import 'models/user_info_dto.dart';

class UserRemote {
  final Dio _dio;

  UserRemote(this._dio);

  Future<UserDto> login(Params params) async {
    final result = await _dio.post(
      APIRoutes.account.login,
      data: params.toMap(),
      cancelToken: params.cancelToken,
    );
    return throwAppException(() => UserDto.fromAPI(result.data));
  }

  Future<void> signUp(Params params) async {
    await _dio.post(
      APIRoutes.account.signUp,
      data: params.toMap(),
      cancelToken: params.cancelToken,
    );
  }

  Future<CompleteInfoDTO> completeInformation(FromDataParams params) async {
    return await _dio
        .post(
          APIRoutes.account.completeInformation,
          data: params.toFromData(),
          cancelToken: params.cancelToken,
        )
        .then((value) =>
            throwAppException(() => CompleteInfoDTO.fromMap(value.data)));
  }

  Future<UserProfileDTO> getUserProfile() async {
    return await _dio
        .get(
          APIRoutes.account.getProfile,
        )
        .then((value) =>
            throwAppException(() => UserProfileDTO.fromMap(value.data)));
  }

  Future<UserInfoDTO> getUserInfo() async {
    return await _dio
        .get(
          APIRoutes.account.getInfo,
        )
        .then((value) =>
            throwAppException(() => UserInfoDTO.fromMap(value.data)));
  }

  Future<UserInfoDTO> updateUserInfo(Params params) async {
    return await _dio
        .put(
          APIRoutes.account.updateInfo,
          data: params.toMap(),
        )
        .then((value) =>
            throwAppException(() => UserInfoDTO.fromMap(value.data)));
  }
}
