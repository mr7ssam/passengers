import 'package:p_core/p_core.dart';

import '../entities/shop_orders.dart';

abstract class IOrderRepo {
  Future<ShopOrders> getOrders();

  Future<void> markAsReady(Params params);
}
