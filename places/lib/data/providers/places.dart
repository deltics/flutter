import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database.dart';
import '../models/location.dart';
import '../models/place.dart';

class Places with ChangeNotifier {
  static Places of(BuildContext context) =>
      Provider.of<Places>(context, listen: false);
  static Places listenerOf(BuildContext context) =>
      Provider.of<Places>(context);

  final List<Place> _items = [];

  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;
  List<Place> get items => [..._items];

  Place byId(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addPlace({
    required String title,
    required File image,
    required Location location,
    String? address,
  }) {
    final place = Place.createNew(
      title: title,
      location: Location(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address,
      ),
      image: image,
    );

    _items.add(place);

    Database.insert("places", {
      "id": place.id,
      "title": place.title,
      "image": place.image.path,
      "latitude": place.location.latitude,
      "longitude": place.location.longitude,
      "address": place.location.address,
    });

    notifyListeners();
  }

  Future<void> fetch() async {
    final data = await Database.select("places");
    if (data.isEmpty) {
      return;
    }

    _items.clear();

    data.forEach(
      (item) => _items.add(
        Place(
          id: item["id"],
          title: item["title"],
          image: File(item["image"]),
          location: Location(
            latitude: item["latitude"],
            longitude: item["longitude"],
            address: item["address"],
          ),
        ),
      ),
    );
  }
}
