import 'package:hive/hive.dart';
import 'package:p_network/p_http_client.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/user/data/local/data_sources/token_storage.dart';
import '../../app/user/domain/entities/token.dart';
import '../../common/const/const.dart';
import '../../core/storage/storage_service.dart';
import '../../core/storage/storage_service_impl.dart';
import '../service_locator.dart';
import 'dart:developer';

Future<void> common() async {
  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);

  si.registerSingleton<IStorageService>(
      StorageService(await Hive.openBox(kAppBoxKey)));

  await _regDioClient();
}

Future<void> _regDioClient() async {
  final DioClient dioClient = DioClient(kBaseAPIUrl);
  final logInterceptor = LogInterceptor(
    responseBody: true,
    error: true,
    requestHeader: true,
    responseHeader: true,
    request: true,
    requestBody: true,
    logPrint: (m) {
      log(m.toString());
    },
  );
  dioClient.interceptors.addAll([
    RefreshTokenInterceptor<AuthTokenModel>(
      dio: dioClient,
      tokenDio: Dio(
        BaseOptions()..baseUrl = kBaseAPIUrl,
      )..interceptors.add(logInterceptor),
      tokenStorage: TokenStorageImpl(si()),
      refreshToken: (token, dio) async {
        final result = await dio.post(
          APIRoutes.user.refreshToken,
          queryParameters: {
            'refreshToken': token.refreshToken,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer ${token.accessToken}',
            },
          ),
        );
        return AuthTokenModel.fromMap(result.data, userType: token.userType);
      },
    ),
    logInterceptor,
  ]);
  si.registerSingleton<Dio>(dioClient);
}
