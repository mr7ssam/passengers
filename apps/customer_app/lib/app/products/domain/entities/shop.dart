class Shop {
  Shop({
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
}

class ShopDetails {
  ShopDetails({
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
}
