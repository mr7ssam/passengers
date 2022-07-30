import 'package:customer_app/app/order/domain/entities/order_details.dart';

import '../entities/order.dart';
import '../entities/order_traking_details.dart';

abstract class IOrderRepo {
  Stream<List<Order>> orders();

  Stream<OrderTrackingDetails> order(String orderId);

  Future<OrderDetails> orderDetails(String orderId);
}
