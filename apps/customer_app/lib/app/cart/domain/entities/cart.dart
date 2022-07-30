import 'package:flutter/material.dart';

import 'cart_item.dart';
import 'cart_items_group.dart';

class Cart<T extends ICartItem> extends ChangeNotifier {
  Cart({
    Map<String, T>? items,
    Map<String, CartItemsGroup<T>>? groups,
  })  : _items = items ?? <String, T>{},
        groups = groups ?? <String, CartItemsGroup<T>>{};

  // <uniqueItemId,....>
  Map<String, T> _items;

  // <uniqueGroupId,....>
  Map<String, CartItemsGroup<T>> groups;

  Map<String, T> get items => _items;

  double get totalPrice => itemsList
      .map((e) => e.totalPrice)
      .reduce((value, element) => value + element);

  List<T> get itemsList => items.values.toList();

  set items(Map<String, T> items) {
    _items = items;
    notifyListeners();
  }

  void add(T item) {
    if (item.count == 0) {
      delete(item);
    } else {
      _addToItems(item);
      _addToGroup(item);
    }
    notifyListeners();
  }

  void _addToItems(T item) {
    final id = item.itemId;
    items[id] = item;
    items[id]!.addListener(() {
      notifyListeners();
    });
  }

  void _addToGroup(T item) {
    if (!groups.containsKey(item.groupId)) {
      final cartItemsGroup = CartItemsGroup<T>(
        id: item.groupId,
        name: item.groupName,
      );
      groups[item.groupId] = cartItemsGroup;
      cartItemsGroup.add(item);
    } else {
      groups[item.groupId]!.add(item);
    }
  }

  void delete(T item) {
    items.remove(item.itemId);
    groups[item.groupId]!.items.remove(item.itemId);
    if (groups[item.groupId]!.items.isEmpty) {
      groups.remove(item.groupId);
    }
    notifyListeners();
  }

  Cart copyWith({
    Map<String, T>? items,
    Map<String, CartItemsGroup<T>>? groups,
  }) {
    return Cart(
      items: items ?? this.items,
      groups: groups ?? this.groups,
    );
  }

  void reset() {
    groups = {};
    items = {};
  }
}
