import 'package:customer_app/app/order/domain/entities/order.dart';
import 'package:p_core/p_core.dart';

import '../domain/entities/order_details.dart';
import '../domain/entities/order_traking_details.dart';
import '../domain/repositories/repo.dart';

class OrderFacade {
  OrderFacade({
    required this.orderRepo,
  });

  final IOrderRepo orderRepo;

  Stream<List<Order>> orders() => orderRepo.orders();

  Stream<OrderTrackingDetails> order(String orderId) =>
      orderRepo.order(orderId);

  Future<ApiResult<OrderDetails>> orderDetails(String orderId) =>
      toApiResult(() => orderRepo.orderDetails(orderId));
}
