import 'package:shop_app/core/params.dart';
import 'package:shop_app/features/category/domain/entities/category.dart';
import 'package:shop_app/features/user/domain/entities/contact.dart';

class UserInfo extends Params {
  UserInfo({
    required this.name,
    required this.category,
    this.address,
    this.lat,
    this.long,
    this.contacts,
  });

  final String name;
  final Category? category;
  final String? address;
  final String? lat;
  final String? long;
  final List<Contact>? contacts;

  UserInfo copyWith({
    String? name,
    Category? category,
    String? address,
    String? lat,
    String? long,
    List<Contact>? contacts,
  }) =>
      UserInfo(
        name: name ?? this.name,
        category: category ?? this.category,
        address: address ?? this.address,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        contacts: contacts ?? this.contacts,
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryId': category?.id,
      'categoryName': category?.name,
      'address': address,
      'lat': lat,
      'long': long,
      'contacts': contacts,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'],
      category: map['category'],
      address: map['address'],
      lat: map['lat'],
      long: map['long'],
      contacts: map['contacts'],
    );
  }
}
