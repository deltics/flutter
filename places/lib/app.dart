import 'package:flutter/material.dart';
import 'package:places/pages/add_place.dart';
import 'package:places/pages/places_list.dart';
import 'package:provider/provider.dart';

import 'data/providers/places.dart';

class PlacesApp extends StatelessWidget {
  const PlacesApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Places(),
        ),
      ],
      child: MaterialApp(
        title: 'Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber.shade700,
          ),
        ),
        home: const PlacesListPage(),
        routes: {
          AddPlacePage.route: (_) => AddPlacePage(),
        },
      ),
    );
  }
}
