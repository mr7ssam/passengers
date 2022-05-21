import 'package:shop_app/app/user/domain/entities/user_profile.dart';

class UserProfileDTO {
  UserProfileDTO({
    required this.name,
    this.categoryName,
    required this.productCount,
    required this.followerCount,
    required this.rate,
    this.imagePath,
    this.contacts = const [],
  });

  final String name;
  final String? categoryName;
  final int productCount;
  final int followerCount;
  final double rate;
  final String? imagePath;
  final List<String> contacts;

  factory UserProfileDTO.fromMap(Map<String, dynamic> map) {
    return UserProfileDTO(
      name: map['name'] ?? '',
      categoryName: map['categoryName'],
      productCount: map['productCount'],
      followerCount: map['followerCount'],
      rate: map['rate'],
      imagePath: map['imagePath'],
      contacts: (map['contacts'] as List).cast<String>(),
    );
  }

  UserProfile toModel({required String userId}) {
    return UserProfile(
      userId: userId,
      name: name,
      followerCount: followerCount,
      productCount: productCount,
      rate: rate,
      imagePath: imagePath,
      categoryName: categoryName,
      contacts: contacts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryName': categoryName,
      'productCount': productCount,
      'followerCount': followerCount,
      'rate': rate,
      'imagePath': imagePath,
      'contacts': contacts,
    };
  }
}
