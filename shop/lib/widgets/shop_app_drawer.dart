import 'package:flutter/material.dart';

import 'app_drawer.dart';
import '../pages/home.dart';
import '../pages/orders.dart';

class ShopAppDrawer extends StatelessWidget {
  const ShopAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      title: "40thieves",
      items: [
        AppDrawerItem(
            title: "Product Catalog",
            iconData: Icons.menu_book,
            route: HomePage.route),
        AppDrawerItem(
          title: "Orders",
          iconData: Icons.receipt_long,
          route: OrdersPage.route,
        ),
      ],
    );
  }
}
