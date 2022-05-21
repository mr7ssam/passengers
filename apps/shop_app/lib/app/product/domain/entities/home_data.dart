import 'package:shop_app/app/product/domain/entities/product.dart';

class HomeData {
  final List<Product> topProducts;
  final List<Product> topOffers;
  final List<Product> popularProducts;

  HomeData({
    required this.topProducts,
    required this.topOffers,
    required this.popularProducts,
  });

  bool get isEmpty =>
      topProducts.isEmpty && topOffers.isEmpty && popularProducts.isEmpty;
}
