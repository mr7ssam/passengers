import 'package:shop_app/app/product/data/remote/models/product_dto.dart';
import 'package:shop_app/app/product/domain/entities/home_data.dart';

class HomeDataDTO {
  final List<ProductDTO> topProducts;
  final List<ProductDTO> topOffers;
  final List<ProductDTO> popularProducts;

  HomeDataDTO({
    required this.topProducts,
    required this.topOffers,
    required this.popularProducts,
  });

  factory HomeDataDTO.fromMap(Map<String, dynamic> map) {
    final topProducts = (map['topProducts'] as List);
    final topOffers = (map['topOffers'] as List);
    final popularProducts = (map['popularProducts'] as List);
    return HomeDataDTO(
      topProducts: topProducts.map((e) => ProductDTO.fromMap(e)).toList(),
      topOffers: topOffers.map((e) => ProductDTO.fromMap(e)).toList(),
      popularProducts:
          popularProducts.map((e) => ProductDTO.fromMap(e)).toList(),
    );
  }

  HomeData toModel() {
    return HomeData(
      topProducts: topProducts.map((e) => e.toModel()).toList(),
      topOffers: topOffers.map((e) => e.toModel()).toList(),
      popularProducts: popularProducts.map((e) => e.toModel()).toList(),
    );
  }
}
