import '../../../domain/entities/order.dart';

class OrderDTO {
  final String id;
  final String serialNumber;
  final String customerId;
  final String dateCreated;
  final int status;

  OrderDTO({
    required this.id,
    required this.serialNumber,
    required this.customerId,
    required this.dateCreated,
    required this.status,
  });

  factory OrderDTO.fromMap(Map<String, dynamic> map) {
    return OrderDTO(
      id: map['id'],
      serialNumber: map['serialNumber'],
      customerId: map['customerId'],
      dateCreated: map['dateCreated'],
      status: map['status'],
    );
  }

  Order toModel() {
    return Order(
      id: id,
      customerId: customerId,
      dateCreated: DateTime.parse(dateCreated),
      serialNumber: serialNumber,
      status: OrderStatus.values[status],
    );
  }
}
