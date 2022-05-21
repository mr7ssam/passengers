import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/user/domain/entities/contact.dart';
import 'package:shop_app/app/user/domain/entities/user_info.dart';

class UserInfoDTO {
  UserInfoDTO({
    required this.name,
    this.categoryId,
    this.categoryName,
    this.address,
    this.lat,
    this.long,
    this.contacts,
  });

  final String name;
  final String? categoryId;
  final String? categoryName;
  final String? address;
  final String? lat;
  final String? long;
  final List<Map<String, dynamic>>? contacts;

  UserInfo toModel() {
    return UserInfo(
      name: name,
      contacts: contacts?.map((e) => Contact.fromMap(e)).toList(),
      category: categoryId == null
          ? null
          : Category(name: categoryName ?? "", id: categoryId!),
      address: address,
      lat: lat,
      long: long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'address': address,
      'lat': lat,
      'long': long,
      'contacts': contacts,
    };
  }

  factory UserInfoDTO.fromMap(Map<String, dynamic> map) {
    return UserInfoDTO(
      name: map['name'] ?? "",
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      address: map['address'],
      lat: map['lat'],
      long: map['long'],
      contacts: (map['contacts'] as List).cast<Map<String, dynamic>>(),
    );
  }
}
