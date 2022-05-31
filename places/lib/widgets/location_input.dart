import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/pages/location_picker.dart';

import "../data/models/location.dart" as model;
import '../helpers/google_maps.dart';

class LocationInput extends StatefulWidget {
  final bool inErrorState;
  final Function(model.Location?) onLocationChanged;

  const LocationInput({
    Key? key,
    required this.inErrorState,
    required this.onLocationChanged,
  }) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  model.Location? _location;
  Uri? _mapUri;
  bool _loadingImage = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _loadingImage = true;
      _mapUri = null;
    });

    widget.onLocationChanged(null);
    final deviceLocation = await Location().getLocation();

    if (mounted) {
      _location = model.Location(
        latitude: deviceLocation.latitude!,
        longitude: deviceLocation.longitude!,
      );
      widget.onLocationChanged(_location!);
    }

    if (mounted) {
      setState(
        () => _mapUri = GoogleMaps.getStaticMapUri(location: _location!),
      );
    }
  }

  Future<void> _selectOnMap() async {
    final location = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => LocationPickerPage(
          initialLocation: _location ??
              model.Location(
                latitude: -36.842,
                longitude: 174.751,
              ),
          allowSelection: true,
        ),
      ),
    );

    if (location == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
            width: 1,
            color: widget.inErrorState ? Colors.red : Colors.blueGrey.shade500,
          ),
        ),
        child: _mapUri == null
            ? Stack(
                fit: StackFit.passthrough,
                children: [
                  Image.asset(
                    "assets/images/earth-map.png",
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: _loadingImage
                        ? const CircularProgressIndicator()
                        : Text(
                            "location required",
                            style: TextStyle(
                                color: widget.inErrorState
                                    ? Colors.red
                                    : Colors.blueGrey.shade600),
                          ),
                  )
                ],
              )
            : Image.network(
                _mapUri.toString(),
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  _loadingImage = false;
                  return child;
                },
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
              ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            icon: const Icon(Icons.map),
            label: const Text("Choose on Map"),
            onPressed: _selectOnMap,
          ),
          TextButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text("Current Location"),
            onPressed: _getCurrentLocation,
          ),
        ],
      )
    ]);
  }
}
