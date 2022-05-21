import 'package:p_network/p_http_client.dart';
import 'package:shop_app/app/user/data/remote/models/complete_info.dart';
import 'package:shop_app/app/user/data/remote/models/user_dto.dart';
import 'package:shop_app/app/user/data/remote/models/user_profile_dto.dart';
import 'package:shop_app/app/user/data/remote/models/working_dto.dart';
import 'package:shop_app/common/const/const.dart';
import 'package:shop_app/core/remote/api_utils.dart';
import 'package:shop_app/core/remote/params.dart';

import 'models/user_info_dto.dart';

class UserRemote {
  final Dio _dio;

  UserRemote(this._dio);

  Future<UserDto> login(Params params) async {
    final result = await _dio.post(
      APIRoutes.shop.login,
      data: params.toMap(),
      cancelToken: params.cancelToken,
    );
    return throwAppException(() => UserDto.fromAPI(result.data));
  }

  Future<void> signUp(Params params) async {
    await _dio.post(
      APIRoutes.shop.signUp,
      data: params.toMap(),
      cancelToken: params.cancelToken,
    );
  }

  Future<CompleteInfoDTO> completeInformation(FormDataParams params) async {
    return await _dio
        .post(
          APIRoutes.shop.completeInformation,
          data: params.toFromData(),
          cancelToken: params.cancelToken,
        )
        .then((value) =>
            throwAppException(() => CompleteInfoDTO.fromMap(value.data)));
  }

  Future<UserProfileDTO> getUserProfile() async {
    return await _dio
        .get(
          APIRoutes.shop.getProfile,
        )
        .then((value) =>
            throwAppException(() => UserProfileDTO.fromMap(value.data)));
  }

  Future<UserInfoDTO> getUserInfo() async {
    return await _dio
        .get(
          APIRoutes.shop.getInfo,
        )
        .then((value) =>
            throwAppException(() => UserInfoDTO.fromMap(value.data)));
  }

  Future<UserInfoDTO> updateUserInfo(Params params) async {
    return await _dio
        .put(
          APIRoutes.shop.updateInfo,
          data: params.toMap(),
        )
        .then((value) =>
            throwAppException(() => UserInfoDTO.fromMap(value.data)));
  }

  Future<String> updateImage(FormDataParams params) async {
    return await _dio
        .put(
          APIRoutes.shop.updateImage,
          data: params.toFromData(),
        )
        .then((value) => value.data);
  }

  Future<WorkingDTO> getWorking() async {
    return await _dio
        .get(
          APIRoutes.shop.getWorkingDays,
        )
        .then((value) => WorkingDTO.fromMap(value.data));
  }

  Future<void> updateWorkDays(Params params) async {
    await _dio.put(
      APIRoutes.shop.updateWorkDays,
      data: params.toMap()['days'],
    );
  }

  Future<void> updateWorkHours(Params params) async {
    await _dio.put(
      APIRoutes.shop.updateWorkHours,
      queryParameters: params.toMap(),
    );
  }
}
