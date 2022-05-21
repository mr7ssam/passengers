import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/user/domain/entities/contact.dart';
import 'package:shop_app/core/remote/params.dart';

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

  @override
  Map<String, dynamic> toMap({bool filterSensitiveData = false}) {
    return {
      'name': name,
      'categoryId': category?.id,
      'categoryName': category?.name,
      if (filterSensitiveData && category != null) 'category': category,
      'address': address,
      'lat': lat,
      'long': long,
      if (lat != null && lat != null && filterSensitiveData)
        'location': LocationResult(
            latLng: LatLng(double.parse(lat!), double.parse(long!))),
      'contacts': contacts ?? [],
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    final LocationResult? locationResult = map['location'];
    return UserInfo(
      name: map['name'],
      category: map['category'],
      address: map['address'],
      lat: locationResult?.latLng.latitude.toString(),
      long: locationResult?.latLng.longitude.toString(),
      contacts: map['contacts'],
    );
  }
}
