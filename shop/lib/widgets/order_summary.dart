import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:math';

import '../models/cart.dart';
import '../models/products.dart';

class OrderSummary extends StatefulWidget {
  final double totalAmount;
  final DateTime orderDateTime;
  final List<CartItem> items;

  const OrderSummary({
    Key? key,
    required this.totalAmount,
    required this.orderDateTime,
    required this.items,
  }) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final products = Products.of(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.totalAmount.toStringAsFixed(2)}"),
            subtitle: Text(
                DateFormat('dd MMM yyyy, hh:mm').format(widget.orderDateTime)),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () {
                setState(() => _expanded = !_expanded);
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 175),
            height: _expanded ? min((widget.items.length * 20) + 10, 180) : 0,
            child: ListView(
              children: widget.items.map((item) {
                final product = products.byId(item.productId)!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${item.quantity} x \$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
