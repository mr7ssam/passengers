import 'package:customer_app/app/order/application/facade.dart';
import 'package:customer_app/app/order/domain/entities/order.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final OrderFacade _orderFacade;

  OrderProvider(this._orderFacade);

  late Stream<List<Order>> _stream;

  Stream<List<Order>> get stream => _stream;

  set stream(Stream<List<Order>> stream) {
    _stream = stream;
    notifyListeners();
  }

  void start() {
    stream = _orderFacade.orders();
  }
}
