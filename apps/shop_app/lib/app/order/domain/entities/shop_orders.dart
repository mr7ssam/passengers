import 'package:flutter/foundation.dart';

import 'order.dart';

@immutable
class ShopOrders {
  final List<Order> ready;
  final List<Order> received;

  const ShopOrders({required this.ready, required this.received});

  ShopOrders makeReady(Order order) {
    final List<Order> newReady = List.from(ready)..insert(0, order);
    final List<Order> newReceived = List.from(received)..remove(order);
    return ShopOrders(ready: newReady, received: newReceived);
  }

  // from map

}
