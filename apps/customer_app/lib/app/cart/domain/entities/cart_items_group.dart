import 'cart_item.dart';

class CartItemsGroup<T extends ICartItem> {
  CartItemsGroup({
    required this.id,
    required this.name,
    Map<String, T>? items,
  }) : items = items ?? {};

  final String id;
  final String name;
  Map<String, T> items;

  List<T> get itemsList => items.values.toList();

  void add(T item) {
    final id = item.itemId;
    if (!items.containsKey(id)) {
      items[id] = item;
    }
  }
}
