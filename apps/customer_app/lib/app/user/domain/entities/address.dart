import 'package:p_core/p_core.dart';

class Address extends Params {
  final String id;
  final String title;
  final String text;
  final String building;
  final String lat;
  final String lng;
  final String? phoneNumber;
  final String? note;

  Address({
    required this.id,
    required this.title,
    required this.text,
    required this.building,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
    required this.note,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'title': title,
      'text': text,
      'lat': double.parse(lat),
      'long': double.parse(lng),
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
      lat: map['lat'].toString(),
      lng: map['lng'].toString(),
      phoneNumber: map['phoneNumber'],
      note: map['note'],
      building: map['building'],
    );
  }
}
