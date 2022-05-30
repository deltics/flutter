import 'package:flutter/material.dart';
import 'package:location/location.dart';

import "../data/models/location.dart" as model;
import '../helpers/google_maps.dart';

class LocationInput extends StatefulWidget {
  final bool inErrorState;

  const LocationInput({
    Key? key,
    required this.inErrorState,
  }) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  bool _loadingImage = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _loadingImage = true;
      _previewImageUrl = null;
    });

    final deviceLocation = await Location().getLocation();

    final location = model.Location(
      latitude: deviceLocation.latitude!,
      longitude: deviceLocation.longitude!,
    );

    final imageUri = GoogleMaps.getStaticMapUri(location: location);

    setState(() => _previewImageUrl = imageUri.toString());
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
        child: _previewImageUrl == null
            ? Stack(
                fit: StackFit.passthrough,
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/earth-map.png",
                      fit: BoxFit.cover,
                    ),
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
                _previewImageUrl!,
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
            onPressed: () {},
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
