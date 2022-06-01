import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/location.dart' as model;

class LocationMapPage extends StatefulWidget {
  final model.Location initialLocation;
  final void Function(model.Location)? onLocationSelected;

  const LocationMapPage({
    Key? key,
    required this.initialLocation,
    this.onLocationSelected,
  }) : super(key: key);

  bool get allowSelection => onLocationSelected != null;

  @override
  State<LocationMapPage> createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  model.Location? _location;

  void _setLocation(LatLng location) {
    setState(() => _location = model.Location.fromLatLng(location));
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.allowSelection) {
      _location = widget.initialLocation;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.allowSelection ? "Select Location..." : "Location"),
        actions: [
          if (widget.allowSelection)
            IconButton(
                icon: const Icon(Icons.done),
                onPressed: _location == null
                    ? null
                    : () {
                        widget.onLocationSelected!(_location!);
                        Navigator.of(context).pop();
                      }),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.allowSelection ? _setLocation : null,
        buildingsEnabled: true,
        compassEnabled: true,
        cameraTargetBounds: widget.allowSelection
            ? CameraTargetBounds.unbounded
            : CameraTargetBounds(LatLngBounds(
                southwest: widget.initialLocation.toLatLng(),
                northeast: widget.initialLocation.toLatLng(),
              )),
        markers: {
          if (_location != null)
            Marker(
              markerId: const MarkerId("m1"),
              position: _location!.toLatLng(),
            ),
        },
      ),
    );
  }
}
