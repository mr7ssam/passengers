import 'dart:async';
import 'package:darq/darq.dart';
import 'package:p_core/p_core.dart';
import 'package:p_core/src/remote/params.dart';
import 'package:p_network/p_http_client.dart';
import 'package:shop_app/app/order/data/remote/data_sources/remote.dart';
import 'package:shop_app/app/order/domain/entities/shop_orders.dart';
import 'package:shop_app/app/order/domain/repositories/repo.dart';

import '../../domain/entities/order.dart';

class OrderRepo implements IOrderRepo {
  final OrderRemote _orderRemote;

  OrderRepo(this._orderRemote);

  @override
  Future<ShopOrders> getOrders() async {
    return throwAppException(() async {
      final ready =
          await _orderRemote.getOrders(ready: true).then(_ordersMapper);
      final received = await _orderRemote.getOrders().then(_ordersMapper);
      return ShopOrders(ready: ready, received: received);
    });
  }

  List<Order> _ordersMapper(Response r) =>
      (r.data as List).map((e) => Order.fromMap(e)).reverse().toList();

  @override
  Future<void> markAsReady(Params params) {
    return _orderRemote.markAsReady(params);
  }
}
