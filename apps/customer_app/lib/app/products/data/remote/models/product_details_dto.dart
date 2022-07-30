import 'package:customer_app/app/products/data/remote/models/shop_dto.dart';
import 'package:p_core/p_core.dart';

import '../../../domain/entities/product_details.dart';
import '../../../domain/entities/tag.dart';

class ProductDetailsDTO {
  ProductDetailsDTO({
    required this.id,
    required this.name,
    this.description,
    required this.shop,
    required this.prepareTime,
    this.imagePath,
    required this.price,
    required this.tagId,
    this.isHaveDiscount = false,
    this.available = true,
    this.discountPrice,
    required this.tagName,
    this.rateDegree = 0,
    this.rateNumber = 0,
    this.discountStartDate,
    this.discountEndDate,
    this.rates = const [],
  });

  final String id;
  final String name;
  final String? description;
  final String? imagePath;
  final double price;
  final double? discountPrice;
  final String tagId;
  final String tagName;
  final bool isHaveDiscount;
  final bool available;
  final double rateDegree;
  final int rateNumber;
  final int prepareTime;
  final String? discountStartDate;
  final String? discountEndDate;
  final List rates;
  final ShopDTO shop;

  factory ProductDetailsDTO.fromMap(Map<String, dynamic> map) {
    return ProductDetailsDTO(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      discountPrice: map['discountPrice'],
      tagId: map['tagId'],
      tagName: map['tagName'] ?? 'very good tag',
      available: map['avilable'],
      isHaveDiscount: map['discountPrice'] != null,
      rateDegree: map['rateDegree'],
      rateNumber: map['rateNumber'],
      prepareTime: map['prepareTime'],
      discountStartDate: map['discountStartDate'],
      discountEndDate: map['discountEndDate'],
      rates: map['rates'] ?? [],
      shop: ShopDTO.fromMap(map['shop']),
    );
  }

  ProductDetails toModel() {
    return ProductDetails(
      id: id,
      name: name,
      description: description,
      imagePath: imagePath,
      price: price,
      discountPrice: discountPrice,
      tag: Tag(id: tagId, name: tagName),
      isHaveDiscount: isHaveDiscount,
      rateDegree: rateDegree,
      rateNumber: rateNumber,
      available: available,
      prepareTime: Duration(seconds: prepareTime),
      discountStartDate: discountStartDate.toDateTimeOrNull(),
      discountEndDate: discountEndDate.toDateTimeOrNull(),
      shop: shop.toModel(),
      rates: rates,
    );
  }
}
