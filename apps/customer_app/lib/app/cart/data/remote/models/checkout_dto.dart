import '../../../domain/entities/checkout.dart';

class CheckoutDTO {
  CheckoutDTO({
    required this.items,
    required this.total,
    required this.time,
  });

  final List<Map<String, dynamic>> items;
  final double total;
  final int time;

  Checkout toModel(String addressId) {
    return Checkout(
      items: items.map((e) => CheckoutItem.fromMap(e)).toList(),
      total: total,
      expectedArrivalTime: time,
      addressId: addressId,
    );
  }

  factory CheckoutDTO.fromMap(Map<String, dynamic> map) {
    return CheckoutDTO(
      items: (map['items'] as List).cast<Map<String, dynamic>>(),
      total: (map['total'] as num).toDouble(),
      time: (map['time'] as num).toInt(),
    );
  }
}
