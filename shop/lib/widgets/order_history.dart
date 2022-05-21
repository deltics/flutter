import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/orders.dart';
import 'order_summary.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  Future? _fetchOrders;

  @override
  initState() {
    super.initState();

    _fetchOrders = Orders.of(context, listen: false).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchOrders,
      builder: (_, future) {
        if (future.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (future.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        return Consumer<Orders>(builder: (_, provider, __) {
          final orders = provider.orders;

          return orders.isEmpty
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
                    );
                  });
        });
      },
    );
  }
}
