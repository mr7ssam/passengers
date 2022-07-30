import 'package:customer_app/app/order/application/facade.dart';
import 'package:customer_app/app/order/data/remote/data_sources/remote.dart';
import 'package:customer_app/app/order/data/repositories/repo.dart';
import 'package:customer_app/app/order/domain/repositories/repo.dart';
import 'package:customer_app/common/signal_r.dart';

import '../service_locator.dart';

void order() {
  si.registerFactory<SignalRService>(() => SignalRService(si()));
  si.registerFactory<OrderRemote>(() => OrderRemote(si(), si()));
  si.registerFactory<IOrderRepo>(() => OrderRepo(si()));
  si.registerFactory<OrderFacade>(
    () => OrderFacade(orderRepo: si()),
  );
}
