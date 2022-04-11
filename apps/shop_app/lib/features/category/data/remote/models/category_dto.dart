import 'package:shop_app/features/category/domain/entities/category.dart';

class CategoryDto {
  final String id;
  final String? path;
  final String name;
  final String? parentId;

  CategoryDto({
    required this.id,
    required this.name,
    this.path,
    this.parentId,
  });

  Category toModel() {
    return Category(id: id, name: name, path: path, parentId: parentId);
  }

  factory CategoryDto.fromMap(Map<String, dynamic> map) {
    return CategoryDto(
      id: map['id'] as String,
      path: map['path'] as String?,
      name: map['name'] as String,
      parentId: map['parentId'] as String?,
    );
  }
}
