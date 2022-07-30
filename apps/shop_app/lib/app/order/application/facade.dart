import 'package:p_core/p_core.dart';
import 'package:shop_app/app/order/domain/repositories/repo.dart';

import '../domain/entities/shop_orders.dart';

class OrderFacade {
  final IOrderRepo _orderRepo;

  OrderFacade(this._orderRepo);

  Future<ApiResult<ShopOrders>> getOrders() {
    return toApiResult(() {
      return _orderRepo.getOrders();
    });
  }

  Future<ApiResult<void>> markAsReady(Params params) {
    return toApiResult(() {
      return _orderRepo.markAsReady(params);
    });
  }
}
