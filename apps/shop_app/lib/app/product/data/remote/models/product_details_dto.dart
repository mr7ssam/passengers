import 'package:shop_app/app/product/domain/entities/product_details.dart';
import 'package:shop_app/core/extension.dart';

import '../../../../category/domain/entities/tag.dart';

class ProductDetailsDto {
  ProductDetailsDto({
    required this.name,
    this.description,
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

  factory ProductDetailsDto.fromMap(Map<String, dynamic> map) {
    return ProductDetailsDto(
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
    );
  }

  ProductDetails toModel(String id) {
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
      rates: rates,
    );
  }
}
