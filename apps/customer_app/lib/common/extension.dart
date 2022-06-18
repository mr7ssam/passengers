import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngEx on LatLng {
  //toMap
  Map<String, dynamic> toMap() {
    return {
      'lat': latitude,
      'lng': longitude,
    };
  }
}
