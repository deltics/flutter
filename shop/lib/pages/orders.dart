import 'package:flutter/material.dart';
import 'package:shop/adapters/platform_page.dart';

import '../models/orders.dart';
import '../widgets/order_summary.dart';
import '../widgets/shop_app_drawer.dart';

class OrdersPage extends StatelessWidget {
  static const route = "/orders";

  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Orders.of(context).orders;

    return PlatformPage(
      title: "Your Orders",
      drawer: const ShopAppDrawer(),
      content: orders.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "You haven't placed any orders yet",
                  softWrap: true,
                ),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, index) {
                final order = orders.elementAt(index);

                return OrderSummary(
                  totalAmount: order.totalAmount,
                  orderDateTime: order.datetime,
                  items: order.items,
                  expanded: false,
                );
              }),
    );
  }
}
