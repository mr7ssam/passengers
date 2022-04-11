import 'package:shop_app/features/category/domain/entities/tag.dart';

class TagDTO {
  TagDTO({
    required this.id,
    required this.name,
    this.logoPath,
    this.shopId,
  });

  final String id;
  final String name;
  final String? logoPath;
  final String? shopId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logoPath': logoPath,
      'shopId': shopId,
    };
  }

  factory TagDTO.fromMap(Map<String, dynamic> map) {
    return TagDTO(
      id: map['id'],
      name: map['name'],
      logoPath: map['logoPath'],
      shopId: map['shopId'],
    );
  }

  Tag toModel() => Tag(id: id, name: name, logoPath: logoPath, shopId: shopId);
}

// "id": "cff27ecd-ee05-4610-7d9a-08da173734fc",
// "name": "tag2",
// "logoPath": null,
// "shopId": "d789ba91-4068-4c67-e66a-08d9faed3115"
