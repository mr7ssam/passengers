import 'package:customer_app/common/utils.dart';

import '../../../domain/entities/shop.dart';

class ShopDTO {
  ShopDTO({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.rate,
    required this.online,
    required this.imagePath,
  });

  final String id;
  final String name;
  final String categoryName;
  final double rate;
  final bool online;
  final String? imagePath;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryName': categoryName,
      'rate': rate,
      'online': online,
      'imagePath': imagePath,
    };
  }

  factory ShopDTO.fromMap(Map<String, dynamic> map) {
    return ShopDTO(
      id: map['id'],
      name: map['name'] ?? '',
      categoryName: map['categoryName'],
      rate: map['rate'] ?? 0.0,
      online: map['online'],
      imagePath: map['imagePath'],
    );
  }
  Shop toModel() {
    return Shop(
      categoryName: categoryName,
      id: id,
      imagePath: buildDocUrl(imagePath),
      name: name,
      online: online,
      rate: rate,
    );
  }
}
