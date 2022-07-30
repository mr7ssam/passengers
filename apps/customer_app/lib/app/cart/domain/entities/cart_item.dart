import 'package:flutter/material.dart';

abstract class ICartItem extends ChangeNotifier {
  ICartItem({
    this.groupId = 'All',
    this.groupName = 'All',
    this.image = 'All',
    required this.itemPrice,
    required this.itemId,
    required this.itemName,
  }) : _count = 1;

  final String itemName;
  final String groupId;
  final String groupName;
  final String? image;
  final String itemId;
  final double itemPrice;
  int _count;

  int get count => _count;

  set count(int count) {
    _count = count;
    notifyListeners();
  }

  double get totalPrice => itemPrice * count;

  void increment({int inc = 1}) {
    count += inc;
  }

  void decrement() {
    if (count > 0) {
      count -= 1;
    }
  }
}
