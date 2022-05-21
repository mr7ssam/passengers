import 'package:shop_app/app/product/application/facade.dart';
import 'package:shop_app/app/product/data/remote/data_sources/remote.dart';
import 'package:shop_app/app/product/data/repositories/repo.dart';
import 'package:shop_app/app/product/domain/repositories/repo.dart';
import 'package:shop_app/injection/service_locator.dart';

void product() {
  si.registerLazySingleton(() => ProductRemote(si()));
  si.registerLazySingleton<IProductRepo>(() => ProductRepo(si()));
  si.registerLazySingleton(() => ProductFacade(si()));
}
