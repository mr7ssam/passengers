import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p_core/p_core.dart';

class Address extends Params
    with EquatableMixin
    implements Comparable<Address> {
  final String id;
  final String title;
  final String text;
  final String building;
  final LatLng location;
  final String? phoneNumber;
  final String? note;
  final bool isCurrentLocation;

  Address({
    required this.id,
    required this.title,
    required this.text,
    required this.building,
    required this.location,
    required this.phoneNumber,
    required this.note,
    this.isCurrentLocation = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'title': title,
      'text': text,
      'lat': location.latitude,
      'long': location.longitude,
      'location': location,
      'phoneNumber': phoneNumber,
      'note': note,
      'building': building,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      // for insert
      id: map['id'] ?? '',
      text: map['text'],
      title: map['title'],
      phoneNumber: map['phoneNumber'],
      note: map['note'],
      building: map['building'],
      location: map['location'] ?? const LatLng(323, 4244),
    );
  }

  @override
  List<Object?> get props => [id];

  Address copyWith({
    String? id,
    String? title,
    String? text,
    String? building,
    LatLng? location,
    String? phoneNumber,
    String? note,
    bool? isCurrentLocation,
  }) {
    return Address(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      building: building ?? this.building,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      note: note ?? this.note,
      isCurrentLocation: isCurrentLocation ?? this.isCurrentLocation,
    );
  }

  @override
  int compareTo(Address other) {
    if (other.isCurrentLocation) {
      return 1;
    }
    return -1;
  }
}
