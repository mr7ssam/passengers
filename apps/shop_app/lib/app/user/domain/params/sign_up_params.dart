import 'package:intl_phone_field/phone_number.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:p_core/p_core.dart';

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
      'userName': phoneNumber,
      'password': password,
      //name is api key
      'name': businessName,
      'description': description,
      //ownerName is api key
      'ownerName': fullName,
      'lat': lat,
      'long': long,
      'address': address,
    };
  }

  factory SignUpParams.fromMap(Map<String, dynamic> map) {
    final LocationResult? locationResult = map['location'];
    return SignUpParams(
      phoneNumber: (map['phoneNumber'] as PhoneNumber).completeNumber,
      password: map['password'] as String,
      fullName: map['ownerName'] as String,
      businessName: map['name'] as String,
      description: map['description'] as String?,
      lat: locationResult?.latLng.latitude.toString(),
      long: locationResult?.latLng.latitude.toString(),
      address: map['address'] as String?,
    );
  }
}
