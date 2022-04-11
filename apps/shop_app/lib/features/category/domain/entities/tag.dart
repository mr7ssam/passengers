class Tag {
  Tag({
    required this.id,
    required this.name,
    this.logoPath,
    this.shopId,
  });

  factory Tag.insert({required String tag}) => Tag(id: '', name: tag);

  final String id;
  final String name;
  final String? logoPath;
  final String? shopId;
}
