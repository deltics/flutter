import 'dart:io';

import 'package:uuid/uuid.dart';

import 'location.dart';

class Place {
  final String id;
  final String title;
  final Location location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });

  Place.createNew({
    required this.title,
    required this.image,
    required this.location,
  }) : id = const Uuid().v4().toString();
}
