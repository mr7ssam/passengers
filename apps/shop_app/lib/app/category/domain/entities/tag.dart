import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  const Tag({
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

  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'name': name,
      if (logoPath != null) 'logoPath': logoPath,
      if (shopId != null) 'shopId': shopId,
    };
  }

  @override
  List<Object?> get props => [id, name];

  Tag copyWith({
    String? id,
    String? name,
    String? logoPath,
    String? shopId,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      logoPath: logoPath ?? this.logoPath,
      shopId: shopId ?? this.shopId,
    );
  }
}
