import 'package:p_core/p_core.dart';

import '../entities/shop.dart';

abstract class IShopRepo {
  Future<ShopDetails> getShopDetails(Params params);
  Future<List<Shop>> getShops(PagingParams params);
}
