import 'package:flutter/material.dart';

import '../adapters/platform_list_tile.dart';

class AppDrawerItem {
  final String title;
  final IconData iconData;
  final String route;

  AppDrawerItem({
    required this.title,
    required this.iconData,
    required this.route,
  });
}

class AppDrawer extends StatelessWidget {
  final String title;
  final List<AppDrawerItem> items;

  const AppDrawer({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const itemStyle = TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 24,
        fontWeight: FontWeight.bold);

    final drawerItems = [
      Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        color: Theme.of(context).colorScheme.primary,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 20),
    ];

    drawerItems.addAll(
      items.map(
        (item) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          child: PlatformListTile(
            leading: Icon(item.iconData, size: 26),
            title: Text(item.title, style: itemStyle),
            onTap: () => Navigator.of(context).pushReplacementNamed(item.route),
          ),
        ),
      ),
    );

    return Drawer(
      child: Column(
        children: drawerItems,
      ),
    );
  }
}
