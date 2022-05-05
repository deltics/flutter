import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/widgets/shopping_cart_item.dart';

import '../models/cart.dart';
import '../models/products.dart';

class OrderSummary extends StatefulWidget {
  final double totalAmount;
  final DateTime orderDateTime;
  final List<CartItem> items;
  bool expanded;

  OrderSummary({
    Key? key,
    required this.totalAmount,
    required this.orderDateTime,
    required this.expanded,
    required this.items,
  }) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> cardItems = [
      ListTile(
          title: Text("\$${widget.totalAmount.toStringAsFixed(2)}"),
          subtitle: Text(
              DateFormat('dd MMM yyyy, hh:mm').format(widget.orderDateTime)),
          trailing: IconButton(
            icon: Icon(
              widget.expanded ? Icons.expand_less : Icons.expand_more,
            ),
            onPressed: () {
              setState(() => widget.expanded = !widget.expanded);
            },
          )),
    ];

    if (widget.expanded) {
      final products = Products.of(context);

      cardItems.addAll(widget.items
          .map((item) => ShoppingCartItem(
                id: item.id,
                price: item.price,
                quantity: item.quantity,
                title: products.byId(item.productId)!.title,
              ))
          .toList());
    }

    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: cardItems,
      ),
    );
  }
}
