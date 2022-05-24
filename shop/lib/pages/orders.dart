import 'package:flutter/material.dart';
import 'package:shop/adapters/platform_page.dart';

import '../widgets/order_history.dart';
import '../widgets/shop_app_drawer.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/orders";

  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PlatformPage(
      title: "Your Orders",
      drawer: ShopAppDrawer(),
      content: OrderHistory(),
    );
  }
}
