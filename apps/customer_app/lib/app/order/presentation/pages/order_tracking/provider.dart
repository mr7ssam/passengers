import 'dart:async';

import 'package:customer_app/app/order/domain/entities/order_traking_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_core/p_core.dart';

import '../../../application/facade.dart';

class OrderTrackingProvider extends ChangeNotifier {
  OrderTrackingProvider(this._productFacade, this.orderId)
      : _state = const PageState.loading();

  final OrderFacade _productFacade;
  final String orderId;
  late StreamSubscription subscription;

  PageState<OrderTrackingDetails> _state;

  PageState<OrderTrackingDetails> get state => _state;

  set state(PageState<OrderTrackingDetails> state) {
    _state = state;
    notifyListeners();
  }

  Future<void> started() async {
    subscription = _productFacade.order(orderId).listen(
      (event) {
        state = PageState.loaded(data: event);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
