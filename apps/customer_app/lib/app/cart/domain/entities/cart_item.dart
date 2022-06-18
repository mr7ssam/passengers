class CartItem<T> {
  CartItem({
    required this.item,
    this.groupId = 'All',
    this.groupName = 'All',
    this.count = 0,
  });

  final T item;
  final String groupId;
  final String groupName;

  int count;

  increment() => count++;

  decrement() {
    if (count > 0) {
      count--;
    }
  }
}
