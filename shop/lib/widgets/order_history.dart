import 'package:flutter/material.dart';

import '../models/orders.dart';
import 'order_summary.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  var _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero)
        .then((_) => Orders.of(context, listen: false).fetchAll())
        .then((_) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final orders = Orders.of(context).orders;

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : orders.isEmpty
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
  }
}
