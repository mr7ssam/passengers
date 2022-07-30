import 'package:customer_app/app/order/domain/entities/order.dart';
import 'package:customer_app/app/order/domain/entities/order_traking_details.dart';

class OrderTrackingDetailsDTO {
  final String id;
  final String serialNumber;
  final String dateCreated;
  final int status;
  final String shopName;
  final double subTotal;
  final double deliveryCost;
  final double totalCost;
  final String? driverNote;
  final String addressTitle;
  final int distance;
  final int time;

  OrderTrackingDetailsDTO({
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

  factory OrderTrackingDetailsDTO.fromMap(Map<String, dynamic> map) {
    return OrderTrackingDetailsDTO(
      id: map['id'],
      serialNumber: map['serialNumber'],
      dateCreated: map['dateCreated'],
      shopName: map['shopName'],
      subTotal: map['subTotal'],
      deliveryCost: (map['deliveryCost'] as num).toDouble(),
      totalCost: map['totalCost'],
      driverNote: map['driverNote'],
      addressTitle: map['addressTitle'],
      distance: map['distance'],
      time: map['time'],
      status: map['status'],
    );
  }
  OrderTrackingDetails toModel() {
    return OrderTrackingDetails(
      id: id,
      serialNumber: serialNumber,
      dateCreated: DateTime.parse(dateCreated),
      shopName: shopName,
      subTotal: subTotal,
      deliveryCost: deliveryCost,
      totalCost: totalCost,
      driverNote: driverNote,
      addressTitle: addressTitle,
      distance: distance,
      status: OrderStatus.values[status],
      time: Duration(minutes: time),
    );
  }
}
