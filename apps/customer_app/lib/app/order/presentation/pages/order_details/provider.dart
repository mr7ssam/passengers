import 'dart:async';

import 'package:customer_app/app/order/domain/entities/order_details.dart';
import 'package:customer_app/app/order/domain/entities/order_traking_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_core/p_core.dart';

import '../../../application/facade.dart';

class OrderDetailsProvider extends ChangeNotifier {
  OrderDetailsProvider(this._productFacade, this.orderId)
      : _state = const PageState.loading();

  final OrderFacade _productFacade;
  final String orderId;

  PageState<OrderDetails> _state;

  PageState<OrderDetails> get state => _state;

  set state(PageState<OrderDetails> state) {
    _state = state;
    notifyListeners();
  }

  Future<void> fetch() async {
    state = const PageState.loading();
    final result = await _productFacade.orderDetails(orderId);
    result.when(
      success: (data) {
        state = PageState.loaded(data: data);
      },
      failure: (errorMessage, exception) {
        state = PageState.error(exception: exception);
      },
    );
  }
}
