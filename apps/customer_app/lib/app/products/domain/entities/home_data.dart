import 'package:customer_app/app/products/domain/entities/product.dart';

class HomeData {
  final List<Product> topProducts;
  final List<Product> newProducts;
  final List<Product> suggestionProducts;
  final List<Product> popularProducts;

  HomeData({
    required this.topProducts,
    required this.popularProducts,
    required this.newProducts,
    required this.suggestionProducts,
  });

  bool get isEmpty =>
      topProducts.isEmpty &&
      newProducts.isEmpty &&
      popularProducts.isEmpty &&
      suggestionProducts.isEmpty;
}
