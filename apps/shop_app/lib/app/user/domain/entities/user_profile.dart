class UserProfile {
  UserProfile({
    required this.userId,
    required this.name,
    this.categoryName,
    required this.productCount,
    required this.followerCount,
    required this.rate,
    this.imagePath,
    this.contacts = const [],
  });

  final String userId;
  final String name;
  final String? categoryName;
  final int productCount;
  final int followerCount;
  final double rate;
  final String? imagePath;
  final List<String> contacts;
}
