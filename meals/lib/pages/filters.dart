import 'package:flutter/material.dart';

import '../adapters/platform_page.dart';

class FiltersPage extends StatefulWidget {
  static const route = '/filters';

  final Function applyFiltersFn;

  const FiltersPage({
    Key? key,
    required this.applyFiltersFn,
  }) : super(key: key);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _showGlutenFree = true;
  var _showLactoseFree = true;
  var _showVegan = true;
  var _showVegetarian = true;

  @override
  Widget build(BuildContext context) {
    return PlatformPage(
      title: 'Filters',
      content: Expanded(
        child: ListView(
          children: [
            _switch(
              title: 'Gluten Free',
              value: _showGlutenFree,
              onChanged: (value) =>
                  widget.applyFiltersFn({'gluten-free': value}),
            ),
            _switch(
              title: 'Lactose Free',
              value: _showLactoseFree,
              onChanged: (value) => setState(() => _showLactoseFree = value),
            ),
            _switch(
              title: 'Vegan',
              value: _showVegan,
              onChanged: (value) => setState(() => _showVegan = value),
            ),
            _switch(
              title: 'Vegetarian',
              value: _showVegetarian,
              onChanged: (value) => setState(() => _showVegetarian = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _switch({
    required String title,
    required bool value,
    required Function onChanged,
  }) {
    return Card(
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(title),
          )),
          Switch(value: value, onChanged: (value) => onChanged(value)),
        ],
      ),
    );
  }
}
