import 'package:flutter/material.dart';

import '../data/providers/places.dart';
import 'location_map.dart';

class PlaceDetailPage extends StatelessWidget {
  static const route = '/place';

  const PlaceDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final place = Places.of(context).byId(id);

    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              place.location.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey.shade600,
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              label: const Text(
                "View On Map...",
              ),
              icon: const Icon(Icons.map_outlined),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => LocationMapPage(
                        initialLocation: place.location,
                      ))),
            ),
          ],
        ));
  }
}
