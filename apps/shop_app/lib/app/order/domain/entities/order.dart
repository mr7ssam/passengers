class Order {
  Order({
    required this.products,
    required this.totalPrice,
    required this.id,
    required this.serialNumber,
    required this.dateCreated,
    required this.shopName,
  });

  final List<Product> products;
  final double totalPrice;
  final String id;
  final String serialNumber;
  final DateTime dateCreated;
  final String? shopName;

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      products:
          (map['products'] as List).map((e) => Product.fromMap(e)).toList(),
      totalPrice: map['totalPrice'],
      id: map['id'],
      serialNumber: map['serialNumber'],
      dateCreated: DateTime.parse(map['dateCreated']),
      shopName: map['shopName'],
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.count,
    required this.price,
  });

  final String id;
  final String name;
  final String? imagePath;
  final int count;
  final double price;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      count: map['count'],
      price: map['price'],
    );
  }
}
