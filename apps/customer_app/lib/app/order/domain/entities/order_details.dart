class OrderDetails {
  final List<Product> products;
  final String? note;
  final double subTotal;
  final double deliveryCost;
  final double totalCost;

  OrderDetails({
    required this.products,
    this.note,
    required this.subTotal,
    required this.deliveryCost,
    required this.totalCost,
  });

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      products:
          (map['products'] as List).map((e) => Product.fromMap(e)).toList(),
      note: map['note'],
      subTotal: map['subTotal'],
      deliveryCost: map['deliveryCost'],
      totalCost: map['totalCost'],
    );
  }
}

class Product {
  final String id;
  final String name;
  final String? imagePath;
  final int count;
  final double price;

  Product({
    required this.id,
    required this.name,
    this.imagePath,
    required this.count,
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      imagePath: map['imagePath'] as String?,
      count: map['count'] as int,
      price: map['price'] as double,
    );
  }
}
