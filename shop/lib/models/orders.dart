import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  static Orders of(BuildContext context, {bool listen = false}) =>
      Provider.of<Orders>(context, listen: listen);

  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void cancel({required String id}) {
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }

  String create({
    required Cart cart,
  }) {
    final id = UniqueKey().toString();

    _orders.insert(
      0,
      Order(
        id: id,
        totalAmount: cart.totalAmount,
        items: cart.items,
        datetime: DateTime.now(),
      ),
    );
    notifyListeners();

    return id;
  }

  List<CartItem> itemsInOrder({required String id}) {
    final order = _orders.where((order) => order.id == id).single;
    return order.items;
  }
}
