import 'package:flutter/material.dart';

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
      body: const Center(
        child: CircularProgressIndicator(color: Colors.green),
      ),
    );
  }
}
