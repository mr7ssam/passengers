import 'package:shop_app/app/order/application/facade.dart';
import 'package:shop_app/app/order/data/remote/data_sources/remote.dart';
import 'package:shop_app/app/order/data/repositories/repo.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../app/order/domain/repositories/repo.dart';

void order() {
  si.registerLazySingleton(() => OrderRemote(si()));
  si.registerLazySingleton<IOrderRepo>(() => OrderRepo(si()));
  si.registerLazySingleton<OrderFacade>(() => OrderFacade(si()));
}
