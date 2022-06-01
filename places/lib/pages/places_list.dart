import 'package:flutter/material.dart';
import 'package:places/pages/place_detail.dart';
import 'package:provider/provider.dart';

import '../data/providers/places.dart';
import '../pages/add_place.dart';

class PlacesListPage extends StatelessWidget {
  static const route = "/";

  const PlacesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Places"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacePage.route);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Places.of(context).fetch(),
        builder: (context, data) => data.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<Places>(
                child: const Center(child: Text("Start adding some places")),
                builder: (context, places, noPlaces) {
                  if (places.length == 0) {
                    return noPlaces!;
                  }

                  final items = places.items;
                  const titleStyle = TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  );

                  return ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final place = items[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            backgroundImage: FileImage(place.image),
                          ),
                          title: Text(place.title, style: titleStyle),
                          subtitle: Text(place.location.address == null ||
                                  place.location.address!.isEmpty
                              ? place.location.toString()
                              : place.location.address!),
                          onTap: () => Navigator.of(context).pushNamed(
                            PlaceDetailPage.route,
                            arguments: place.id,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
