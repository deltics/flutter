import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/location.dart';

class LocationPickerPage extends StatefulWidget {
  final Location initialLocation;
  final bool allowSelection;

  const LocationPickerPage({
    Key? key,
    required this.initialLocation,
    this.allowSelection = false,
  }) : super(key: key);

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location..."),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16,
        ),
      ),
    );
  }
}
