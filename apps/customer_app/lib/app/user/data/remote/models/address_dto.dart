import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressDTO {
  final String id;
  final String title;
  final String text;
  final String building;
  final String lat;
  final String lng;
  final String? phoneNumber;
  final String? note;
  final bool isCurrentLocation;

  AddressDTO({
    required this.id,
    required this.title,
    required this.building,
    required this.text,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
    required this.note,
    required this.isCurrentLocation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'title': title,
      'building': building,
      'lat': lat,
      'lng': lng,
      'phoneNumber': phoneNumber,
      'note': note,
    };
  }

  factory AddressDTO.fromMap(Map<String, dynamic> map) {
    return AddressDTO(
      id: map['id'],
      text: map['text'],
      title: map['title'],
      building: map['building'],
      lat: map['lat'],
      lng: map['long'],
      phoneNumber: map['phoneNumber'],
      note: map['note'],
      isCurrentLocation: map['isCurrentLocation'],
    );
  }

  Address toModel() {
    return Address(
      id: id,
      text: text,
      title: title,
      building: building,
      phoneNumber: phoneNumber,
      location: LatLng(double.parse(lat), double.parse(lng)),
      note: note,
      isCurrentLocation: isCurrentLocation,
    );
  }
}
