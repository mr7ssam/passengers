import 'package:customer_app/app/products/data/remote/models/product_dto.dart';

import '../../../domain/entities/home_data.dart';

class HomeDataDTO {
  final List<ProductDTO> topProducts;
  final List<ProductDTO> newProducts;
  final List<ProductDTO> popularProducts;
  final List<ProductDTO> suggestionProducts;

  HomeDataDTO({
    required this.topProducts,
    required this.newProducts,
    required this.popularProducts,
    required this.suggestionProducts,
  });

  factory HomeDataDTO.fromMap(Map<String, dynamic> map) {
    final topProducts = (map['topProducts'] as List);
    final newProducts = (map['newProducts'] as List);
    final popularProducts = (map['popularProducts'] as List);
    final suggestionProducts = (map['suggestionProducts'] as List);
    return HomeDataDTO(
      topProducts: topProducts.map((e) => ProductDTO.fromMap(e)).toList(),
      newProducts: newProducts.map((e) => ProductDTO.fromMap(e)).toList(),
      suggestionProducts:
          suggestionProducts.map((e) => ProductDTO.fromMap(e)).toList(),
      popularProducts:
          popularProducts.map((e) => ProductDTO.fromMap(e)).toList(),
    );
  }

  HomeData toModel() {
    return HomeData(
      topProducts: topProducts.map((e) => e.toModel()).toList(),
      newProducts: newProducts.map((e) => e.toModel()).toList(),
      popularProducts: popularProducts.map((e) => e.toModel()).toList(),
      suggestionProducts: suggestionProducts.map((e) => e.toModel()).toList(),
    );
  }
}
