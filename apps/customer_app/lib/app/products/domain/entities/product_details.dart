import '../../domain/entities/tag.dart';

class ProductDetails {
  ProductDetails({
    required this.id,
    required this.name,
    this.description,
    required this.tag,
    required this.prepareTime,
    this.imagePath,
    required this.price,
    this.isHaveDiscount = false,
    this.available = true,
    this.discountPrice,
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
  final Tag tag;
  final bool isHaveDiscount;
  final bool available;
  final double rateDegree;
  final int rateNumber;
  final Duration prepareTime;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;
  final List rates;

  ProductDetails copyWith({
    String? id,
    String? name,
    String? description,
    String? imagePath,
    double? price,
    double? discountPrice,
    Tag? tag,
    bool? isHaveDiscount,
    bool? available,
    double? rateDegree,
    int? rateNumber,
    Duration? prepareTime,
    DateTime? discountStartDate,
    DateTime? discountEndDate,
    List? rates,
  }) {
    return ProductDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      tag: tag ?? this.tag,
      isHaveDiscount: isHaveDiscount ?? this.isHaveDiscount,
      rateDegree: rateDegree ?? this.rateDegree,
      rateNumber: rateNumber ?? this.rateNumber,
      available: available ?? this.available,
      prepareTime: prepareTime ?? this.prepareTime,
      discountStartDate: discountStartDate ?? this.discountStartDate,
      discountEndDate: discountEndDate ?? this.discountEndDate,
      rates: rates ?? this.rates,
    );
  }
}
