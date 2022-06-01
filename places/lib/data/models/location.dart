import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final double latitude;
  final double longitude;
  final String? address;

  Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  Location.fromLatLng(LatLng latLng)
      : latitude = latLng.latitude,
        longitude = latLng.longitude,
        address = null;

  LatLng toLatLng() => LatLng(latitude, longitude);

  @override
  String toString() {
    return "Lat: ${latitude.toStringAsFixed(3)}, Lng: ${longitude.toStringAsFixed(3)}";
  }
}
