import 'package:hive/hive.dart';
import 'package:p_network/p_http_client.dart';
import 'package:p_network/p_refresh_token.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/features/user/data/local/data_sources/token_storage.dart';
import 'package:shop_app/features/user/data/local/data_sources/user_storage.dart';
import 'package:shop_app/features/user/data/local/models/token.dart';

import '../../common/const/const.dart';
import '../../core/storage/storage_service.dart';
import '../../core/storage/storage_service_impl.dart';
import '../service_locator.dart';

Future<void> common() async {
  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);

  si.registerSingleton<IStorageService>(
      StorageService(await Hive.openBox(kAppBoxKey)));

  await _regDioClient();
}

Future<void> _regDioClient() async {
  final DioClient dioClient = DioClient(kBaseUrl);
  dioClient.interceptors.addAll([
    RefreshTokenInterceptor<AuthTokenModel>(
      dio: dioClient,
      tokenStorage: TokenStorageImpl(si()),
      refreshToken: (token, dio) async {
        final result = await dio.post(APIRoutes.account.refreshToken, data: {
          'refreshToken': token.refreshToken,
          'id': si<UserStorage>().read()!.id,
        });
        return AuthTokenModel.fromMap(result.data);
      },
    ),
    LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    ),
  ]);
  si.registerSingleton<Dio>(dioClient);
}
