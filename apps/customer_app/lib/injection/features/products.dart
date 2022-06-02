import 'package:customer_app/app/products/application/facade.dart';
import 'package:customer_app/app/products/data/repositories/category_repo.dart';
import 'package:customer_app/app/products/domain/repositories/product_repo.dart';
import 'package:customer_app/app/products/domain/repositories/shop_repo.dart';
import 'package:customer_app/injection/service_locator.dart';

import '../../app/products/data/remote/data_sources/category_remote.dart';
import '../../app/products/data/remote/data_sources/product_remote.dart';
import '../../app/products/data/remote/data_sources/shop_remote.dart';
import '../../app/products/data/repositories/product_repo.dart';
import '../../app/products/data/repositories/shop_repo.dart';
import '../../app/products/domain/repositories/category_repo.dart';

void products() {
  si.registerSingleton(ProductRemote(si()));
  si.registerSingleton(CategoryRemote(si()));
  si.registerSingleton(ShopRemote(si()));
  si.registerSingleton<IShopRepo>(ShopRepo(si()));
  si.registerSingleton<ICategoryRepo>(CategoryRepo(si()));
  si.registerSingleton<IProductRepo>(ProductRepo(si()));
  si.registerSingleton(
    ProductFacade(shopRepo: si(), categoryRepo: si(), productRepo: si()),
  );
}
