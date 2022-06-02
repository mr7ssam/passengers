import 'package:customer_app/common/utils.dart';

import '../../../domain/entities/shop.dart';

class ShopDetailsDTO {
  ShopDetailsDTO({
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
  final int rate;
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

  factory ShopDetailsDTO.fromMap(Map<String, dynamic> map) {
    return ShopDetailsDTO(
      id: map['id'],
      name: map['name'],
      categoryName: map['categoryName'],
      rate: map['rate'],
      online: map['online'],
      imagePath: map['imagePath'],
    );
  }
  ShopDetails toModel() {
    return ShopDetails(
      categoryName: categoryName,
      id: id,
      imagePath: buildDocUrl(imagePath),
      name: name,
      online: online,
      rate: rate,
    );
  }
}
