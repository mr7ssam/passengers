import 'package:customer_app/app/cart/application/facade.dart';
import 'package:customer_app/app/cart/data/remote/data_sources/remote.dart';
import 'package:customer_app/app/cart/data/repositories/repo.dart';

import '../../app/cart/domain/repositories/repo.dart';
import '../service_locator.dart';

void cart() {
  si.registerFactory<CartRemote>(() => CartRemote(si()));
  si.registerFactory<ICartRepo>(() => CartRepo(si()));
  si.registerFactory<CartFacade>(() => CartFacade(si()));
}
