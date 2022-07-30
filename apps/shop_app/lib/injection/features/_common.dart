import 'package:hive/hive.dart';
import 'package:p_network/p_http_client.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/app/user/data/local/data_sources/token_storage.dart';
import 'package:shop_app/app/user/data/local/models/token.dart';
import 'package:shop_app/common/storage/storage_service.dart';
import 'package:shop_app/common/storage/storage_service_impl.dart';

import '../../common/const/const.dart';
import '../service_locator.dart';

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
          APIRoutes.shop.refreshToken,
          queryParameters: {
            'refreshToken': token.refreshToken,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer ${token.accessToken}',
            },
          ),
        );
        return AuthTokenModel.fromMap(result.data);
      },
    ),
    logInterceptor,
  ]);
  si.registerSingleton<Dio>(dioClient);
}
