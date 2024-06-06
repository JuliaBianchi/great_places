import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../models/place.dart';
import '../utils/db_util.dart';
import '../utils/location_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Places> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => Places(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlacesLocation(
              latitude: item['latitude'],
              longitude: item['longitude'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  List<Places> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Places itemByIndex(int index) {
    return _items[index];
  }

  Future<void> addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Places(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlacesLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
