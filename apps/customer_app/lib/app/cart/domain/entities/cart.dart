import 'cart_item.dart';
import 'cart_items_group.dart';

class Cart<T> {
  Cart({
    this.items = const [],
    this.groups = const {},
  });

  List<CartItem<T>> items;
  Map<String, CartItemsGroup<T>> groups = {};

  add(CartItem<T> item) {
    items.add(item);
    if (groups.containsKey(item.groupId)) {
      groups[item.groupId]!.items.add(item);
    } else {
      groups[item.groupId] = CartItemsGroup<T>(
        id: item.groupId,
        name: item.groupId,
        items: [item],
      );
    }
  }

  delete(CartItem<T> item) {
    items.remove(item);
    groups[item.groupId]!.items.remove(item);
  }
}
