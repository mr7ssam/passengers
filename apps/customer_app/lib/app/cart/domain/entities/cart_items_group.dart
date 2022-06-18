import 'cart_item.dart';

class CartItemsGroup<T> {
  CartItemsGroup({
    required this.id,
    required this.name,
    this.items = const [],
  });

  final String id;
  final String name;
  List<CartItem<T>> items;
}
