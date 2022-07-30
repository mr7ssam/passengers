import 'package:customer_app/app/order/domain/entities/order.dart';

class OrderTrackingDetails {
  final String id;
  final String serialNumber;
  final OrderStatus status;
  final DateTime dateCreated;
  final String shopName;
  final double subTotal;
  final double deliveryCost;
  final double totalCost;
  final String? driverNote;
  final String addressTitle;
  final int distance;
  final Duration time;

  OrderTrackingDetails({
    required this.id,
    required this.serialNumber,
    required this.dateCreated,
    required this.status,
    required this.shopName,
    required this.subTotal,
    required this.deliveryCost,
    required this.totalCost,
    required this.driverNote,
    required this.addressTitle,
    required this.distance,
    required this.time,
  });

  bool isOnWay() => status == OrderStatus.collected;
}
