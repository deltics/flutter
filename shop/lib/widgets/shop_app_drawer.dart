import 'package:flutter/material.dart';

import '../pages/products.dart';
import 'app_drawer.dart';
import '../pages/home.dart';
import '../pages/orders.dart';

class ShopAppDrawer extends StatelessWidget {
  const ShopAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      title: "40thieves",
      itemColor: Colors.blueGrey.shade800,
      items: [
        AppDrawerItem(
            title: "Shop", iconData: Icons.shop, route: HomePage.route),
        AppDrawerItem(
          title: "Orders",
          iconData: Icons.move_to_inbox,
          route: OrdersPage.route,
        ),
        AppDrawerItem(
          title: "Products",
          iconData: Icons.edit,
          route: ProductsPage.route,
        ),
      ],
    );
  }
}
