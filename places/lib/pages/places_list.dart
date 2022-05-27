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
      body: Consumer<Places>(
        child: const Center(child: Text("Start adding some places")),
        builder: (context, places, noPlaces) {
          if (places.length == 0) {
            return noPlaces!;
          }

          final items = places.items;
          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = items[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(place.image),
                  ),
                  title: Text(place.title),
                  onTap: () =>
                      Navigator.of(context).pushNamed(PlaceDetailPage.route));
            },
          );
        },
      ),
    );
  }
}
