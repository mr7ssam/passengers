import 'package:intl_phone_field/phone_number.dart';
import 'package:shop_app/core/params.dart';

class SignUpParams extends Params {
  final String phoneNumber;
  final String password;
  final String fullName;
  final String? description;
  final String businessName;
  final String? lat;
  final String? long;
  final String? address;

  SignUpParams({
    required this.phoneNumber,
    required this.password,
    required this.fullName,
    required this.businessName,
    this.description,
    this.lat,
    this.long,
    this.address,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      //name is api key
      'name': fullName,
      'description': description,
      //ownerName is api key
      'ownerName': businessName,
      'lat': lat,
      'long': long,
      'address': address,
    };
  }

  factory SignUpParams.fromMap(Map<String, dynamic> map) {
    return SignUpParams(
      phoneNumber: (map['phoneNumber'] as PhoneNumber).completeNumber,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      businessName: map['businessName'] as String,
      description: map['description'] as String?,
      lat: map['lat'] as String?,
      long: map['long'] as String?,
      address: map['address'] as String?,
    );
  }
}
