import 'package:p_design/p_design.dart';

class Order {
  final String id;
  final String serialNumber;
  final String customerId;
  final DateTime dateCreated;
  final OrderStatus status;

  Order({
    required this.id,
    required this.serialNumber,
    required this.customerId,
    required this.dateCreated,
    required this.status,
  });
}

enum OrderStatus {
  none(0, '', '', ''),
  pending(1, 'Pending', 'Waiting for approve it ⏰', Images.orderPending),
  accepted(2, 'In progress', 'Your food is cooking 🍗', Images.orderInProgress),
  assigned(2, 'In progress', 'Your food is cooking 🍗', Images.orderInProgress),
  collected(3, 'On way', 'Stay tuned, order is coming 🛵', Images.orderOnWay),
  completed(4, 'Completed', 'Your order is completed ☑', Images.orderComplete),
  canceled(5, 'Canceled', 'Your order is canceled ❌', ''),
  refused(6, 'Refused', 'Your order is refused ❌', '');

  const OrderStatus(
      this.statusIndex, this.label, this.description, this.svgPath);

  final String label;
  final String description;
  final String svgPath;
  final int statusIndex;
  bool isCanceledOrRefused() => statusIndex > 4;
}
