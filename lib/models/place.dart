import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const PlacesLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

class Places {
  final String id;
  final String title;
  final PlacesLocation? location;
  final File image;

  Places({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
