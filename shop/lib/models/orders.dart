import 'package:flutter/material.dart';

import 'cart.dart';

class Order {
  final String id;
  final double totalAmount;
  final List<CartItem> items;
  final DateTime datetime;

  Order({
    required this.id,
    required this.totalAmount,
    required this.items,
    required this.datetime,
  });
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void create({
    required List<CartItem> items,
    required double totalAmount,
  }) {
    _orders.insert(
      0,
      Order(
        id: UniqueKey().toString(),
        totalAmount: totalAmount,
        items: items,
        datetime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
