import 'package:reactive_image_picker/image_file.dart';

import '../../domain/entities/tag.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    this.description,
    this.prepareTime,
    this.imagePath,
    required this.price,
    required this.avilable,
    required this.tagId,
    this.tag,
    this.isNew = false,
    this.isHaveDiscount = false,
    this.discount = 0,
    this.rate = 0,
    this.buyers = 0,
    this.index,
  });

  final String id;
  final String name;
  final String? description;
  final Duration? prepareTime;
  final String? imagePath;
  final double? price;
  final bool avilable;
  final String tagId;
  final Tag? tag;
  final bool isNew;
  final bool isHaveDiscount;
  final double? discount;
  final double rate;
  final int buyers;
  final int? index;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    Duration? prepareTime,
    String? imagePath,
    double? price,
    bool? avilable,
    String? tagId,
    Tag? tag,
    bool? isNew,
    bool? isHaveDiscount,
    double? discount,
    double? rate,
    int? buyers,
    int? index,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        prepareTime: prepareTime ?? this.prepareTime,
        imagePath: imagePath ?? this.imagePath,
        price: price ?? this.price,
        avilable: avilable ?? this.avilable,
        tagId: tagId ?? this.tagId,
        tag: tag ?? this.tag,
        isNew: isNew ?? this.isNew,
        isHaveDiscount: isHaveDiscount ?? this.isHaveDiscount,
        discount: discount ?? this.discount,
        rate: rate ?? this.rate,
        index: index ?? this.index,
        buyers: buyers ?? this.buyers,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'prepareTime': prepareTime,
      'image': ImageFile(imageUrl: imagePath),
      'price': price?.toInt(),
      'tag': tag,
      'avilable': avilable,
      'tagId': tagId,
      'isNew': isNew,
      'isHaveDiscount': isHaveDiscount,
      'discount': discount,
      'rate': rate,
      'buyers': buyers,
    };
  }
}
