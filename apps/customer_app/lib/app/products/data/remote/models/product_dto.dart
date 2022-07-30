import '../../../../../common/utils.dart';
import '../../../domain/entities/product.dart';

class ProductDTO {
  ProductDTO({
    required this.id,
    required this.name,
    this.description,
    this.prepareTime,
    this.imagePath,
    required this.price,
    this.avilable = true,
    required this.tagId,
    this.isNew = false,
    this.isHaveDiscount = false,
    this.discount,
    this.rate = 0,
    this.buyers,
    this.shopId,
    this.shopImagePath,
    this.shopOnline,
  });

  final String id;
  final String name;
  final String? description;
  final int? prepareTime;
  final int? buyers;
  final String? imagePath;
  final double price;
  final bool? avilable;
  final String tagId;
  final bool? isNew;
  final bool? isHaveDiscount;
  final double? discount;
  final double rate;
  final String? shopId;
  final String? shopImagePath;
  final bool? shopOnline;

  Product toModel() {
    return Product(
      id: id,
      name: name,
      description: description,
      prepareTime: prepareTime != null ? Duration(seconds: prepareTime!) : null,
      imagePath: buildDocUrl(imagePath),
      price: price,
      avilable: avilable ?? true,
      tagId: tagId,
      isNew: isNew ?? false,
      isHaveDiscount: isHaveDiscount ?? false,
      discount: discount,
      rate: rate,
      buyers: buyers ?? 0,
      shopId: shopId,
      shopImagePath: shopImagePath,
      shopOnline: shopOnline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'prepareTime': prepareTime,
      'buyers': buyers,
      'imagePath': imagePath,
      'price': price,
      'avilable': avilable,
      'tagId': tagId,
      'isNew': isNew,
      'isHaveDiscount': isHaveDiscount,
      'discount': discount,
      'rate': rate,
      'shopId': shopId,
      'shopImagePath': shopImagePath,
      'shopOnline': shopOnline,
    };
  }

  factory ProductDTO.fromMap(Map<String, dynamic> map) {
    return ProductDTO(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      prepareTime: map['prepareTime'],
      buyers: map['buyers'],
      imagePath: map['imagePath'],
      price: map['price'],
      avilable: map['avilable'],
      tagId: map['tagId'] ?? '',
      isNew: map['isNew'],
      isHaveDiscount: map['isHaveDiscount'],
      discount: map['discount'],
      rate: map['rate'],
      shopId: map['shopId'],
      shopImagePath: map['shopImagePath'],
      shopOnline: map['shopOnline'],
    );
  }
}
