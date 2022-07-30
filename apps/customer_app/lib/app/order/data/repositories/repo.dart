import 'package:customer_app/app/order/domain/entities/order.dart';
import 'package:customer_app/app/order/domain/entities/order_details.dart';
import 'package:customer_app/app/order/domain/entities/order_traking_details.dart';

import '../../domain/repositories/repo.dart';
import 'package:rxdart/rxdart.dart';

import '../remote/data_sources/remote.dart';

class OrderRepo extends IOrderRepo {
  final OrderRemote remote;
  final BehaviorSubject<List<Order>> _behaviorSubject;
  final BehaviorSubject<OrderTrackingDetails> _orderBehaviorSubject;

  OrderRepo(this.remote)
      : _behaviorSubject = BehaviorSubject<List<Order>>(),
        _orderBehaviorSubject = BehaviorSubject<OrderTrackingDetails>();

  @override
  Stream<List<Order>> orders() {
    remote.orders(
      on: (data) {
        _behaviorSubject.add(data.map((e) => e.toModel()).toList());
      },
    );
    return _behaviorSubject.stream;
  }

  @override
  Stream<OrderTrackingDetails> order(String orderId) {
    remote.order(
      orderId: orderId,
      on: (data) {
        final id = data.id;
        if (id == orderId) {
          _orderBehaviorSubject.add(data.toModel());
        }
      },
    );
    return _orderBehaviorSubject.stream;
  }

  @override
  Future<OrderDetails> orderDetails(String orderId) {
    return remote.orderDetails(orderId: orderId).then(
          (value) => OrderDetails.fromMap(value.data),
        );
  }
}
