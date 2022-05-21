class Category {
  final String id;
  final String? path;
  final String name;
  final String? parentId;

  Category({
    required this.id,
    required this.name,
    this.path,
    this.parentId,
  });
}
