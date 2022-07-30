import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p_core/p_core.dart';
import 'package:shop_app/app/order/application/facade.dart';
import 'package:shop_app/app/order/domain/entities/shop_orders.dart';

import '../../domain/entities/order.dart';
import 'order_page.dart';

const _removeDuration = Duration(milliseconds: 300);

class OrdersProvider extends ChangeNotifier {
  final OrderFacade _orderFacade;

  OrdersProvider(this._orderFacade)
      : _pageState = const PageState.loading(),
        _shopOrders = const ShopOrders(ready: [], received: []);

  PageState<Key> _pageState;

  PageState<Key> get pageState => _pageState;

  set pageState(PageState<Key> pageState) {
    _pageState = pageState;
    notifyListeners();
  }

  ShopOrders _shopOrders;

  ShopOrders get shopOrders => _shopOrders;

  set shopOrders(ShopOrders shopOrders) {
    _shopOrders = shopOrders;
    notifyListeners();
  }

  Future<void> fetch() async {
    final result = await _orderFacade.getOrders();
    result.when(
      success: (data) {
        pageState = PageState.loaded(data: UniqueKey());
        shopOrders = data;
      },
      failure: (message, exception) {
        pageState = PageState.error(exception: exception);
      },
    );
  }

  Future<void> markReady(Order order, BuildContext context, int index) async {
    final result = await _orderFacade.markAsReady(ParamsWrapper({
      'orderId': order.id,
    }));

    result.when(
      success: (data) async {
        AnimatedList.of(context).removeItem(
            index,
            (context, animation) => OrderListTile(
                  animation: animation,
                  ready: false,
                  order: order,
                  index: index,
                ),
            duration: _removeDuration);
        await Future.delayed(_removeDuration);

        shopOrders = shopOrders.makeReady(order);
      },
      failure: (message, exception) {
        EasyLoading.showError(message);
      },
    );
  }
}
