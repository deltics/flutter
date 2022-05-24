import 'package:flutter/material.dart';

import '../adapters/platform_list_tile.dart';

class AppDrawerItem {
  final String title;
  final IconData iconData;
  final String? route;
  final Function? onPressed;

  AppDrawerItem(
      {required this.title,
      required this.iconData,
      this.route,
      this.onPressed});
}

class AppDrawer extends StatelessWidget {
  final String title;
  final List<AppDrawerItem> items;
  final Color itemColor;

  const AppDrawer({
    Key? key,
    required this.title,
    required this.items,
    required this.itemColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemStyle = TextStyle(
        color: itemColor,
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        fontWeight: FontWeight.bold);

    final drawerItems = [
      Container(
        height: 110,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ];

    drawerItems.addAll(
      items.map(
        (item) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          child: PlatformListTile(
            leading: Icon(
              item.iconData,
              size: 26,
              color: itemColor,
            ),
            title: Text(item.title, style: itemStyle),
            onTap: item.route != null
                ? () => Navigator.of(context).pushReplacementNamed(item.route!)
                : item.onPressed,
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
