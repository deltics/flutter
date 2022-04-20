import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

import '../adapters/platform_page.dart';

class FiltersPage extends StatefulWidget {
  static const route = '/filters';

  final Function applyFilterFn;
  final List<MealSuitability> filters;

  const FiltersPage({
    Key? key,
    required this.filters,
    required this.applyFilterFn,
  }) : super(key: key);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformPage(
      title: 'Filters',
      content: Expanded(
        child: ListView(
          children: [
            _switch(
              title: 'Gluten Free',
              suitability: MealSuitability.glutenFree,
            ),
            _switch(
              title: 'Lactose Free',
              suitability: MealSuitability.lactoseFree,
            ),
            _switch(
              title: 'Vegan',
              suitability: MealSuitability.vegan,
            ),
            _switch(
              title: 'Vegetarian',
              suitability: MealSuitability.vegetarian,
            ),
          ],
        ),
      ),
    );
  }

  Widget _switch({
    required String title,
    required MealSuitability suitability,
  }) {
    return Card(
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(title),
          )),
          Switch(
            value: widget.filters.contains(suitability),
            onChanged: (value) => widget.applyFilterFn(
              suitability: suitability,
              show: value,
            ),
          ),
        ],
      ),
    );
  }
}
