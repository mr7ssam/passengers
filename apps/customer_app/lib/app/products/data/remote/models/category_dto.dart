import '../../../domain/entities/category.dart';

class CategoryDTO {
  final String id;
  final String? path;
  final String name;
  final String? parentId;

  CategoryDTO({
    required this.id,
    required this.name,
    this.path,
    this.parentId,
  });

  Category toModel() {
    return Category(id: id, name: name, path: path, parentId: parentId);
  }

  factory CategoryDTO.fromMap(Map<String, dynamic> map) {
    return CategoryDTO(
      id: map['id'] as String,
      path: map['path'] as String?,
      name: map['name'] as String,
      parentId: map['parentId'] as String?,
    );
  }
}
