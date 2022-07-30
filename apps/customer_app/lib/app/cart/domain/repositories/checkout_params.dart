import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:p_core/p_core.dart';

import '../entities/cart.dart';

class CheckoutParams extends Params {
  CheckoutParams({
    required this.cart,
    required this.address,
  });

  final Cart cart;
  final Address address;

  @override
  Map<String, dynamic> toMap() {
    return {
      'products': cart.itemsList
          .map(
            (item) => {'id': item.itemId, 'count': item.count},
          )
          .toList(),
      'shops': cart.groups.values.map((e) => {'id': e.id}).toList(),
      'addressId': address.id,
    };
  }
}
