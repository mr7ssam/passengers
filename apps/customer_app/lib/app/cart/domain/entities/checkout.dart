import 'package:p_core/p_core.dart';

class Checkout extends Params {
  Checkout({
    required this.items,
    required this.total,
    required this.addressId,
    required this.expectedArrivalTime,
  });

  final List<CheckoutItem> items;
  final double total;
  final String addressId;
  final int expectedArrivalTime;

  @override
  Map<String, dynamic> toMap() {
    return {
      'cart': items.map((e) => e.toMap()).toList(),
      'addressId': addressId,
    };
  }
}

class CheckoutItem extends IMap {
  CheckoutItem({
    required this.shopName,
    required this.shopId,
    required this.products,
  });

  final List<CheckoutProduct> products;
  final String shopName;
  final String shopId;

  double get total => products.fold(0, (acc, e) => acc + e.productPrice);

  @override
  Map<String, dynamic> toMap() {
    return {
      'products': products.map((e) => e.toMap()).toList(),
      'name': shopName,
      'id': shopId,
    };
  }

  factory CheckoutItem.fromMap(Map<String, dynamic> map) {
    return CheckoutItem(
      products: (map['products'] as List)
          .map((e) => CheckoutProduct.fromMap(e))
          .toList(),
      shopName: map['name'] as String,
      shopId: map['id'] as String,
    );
  }
}

class CheckoutProduct extends IMap {
  CheckoutProduct({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
  });

  final String productId;
  final String productName;
  final double productPrice;
  final int productQuantity;

  factory CheckoutProduct.fromMap(Map<String, dynamic> map) {
    return CheckoutProduct(
      productId: map['id'] as String,
      productName: map['name'] as String,
      productPrice: map['price'] as double,
      productQuantity: map['count'] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'name': productName,
      'price': productPrice,
      'count': productQuantity,
    };
  }
}
