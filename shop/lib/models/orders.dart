import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../firebase.dart';
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalAmount": totalAmount,
        "datetime": DateFormat('dd MMM yyyy, hh:mm').format(datetime),
      };
}

class Orders with ChangeNotifier {
  final _uri = firebaseUri("orders.json");

  static Orders of(BuildContext context, {bool listen = false}) =>
      Provider.of<Orders>(context, listen: listen);

  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void cancel({required String id}) {
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }

  Future<String> create({
    required Cart cart,
  }) async {
    final id = const Uuid().v4();

    final order = Order(
      id: id,
      totalAmount: cart.totalAmount,
      items: cart.items,
      datetime: DateTime.now(),
    );

    try {
      var uri = firebaseUri("orders/$id.json");
      var response = await http.put(uri, body: jsonEncode(order));
      if (response.statusCode != HttpStatus.ok) {
        throw "Unexpected ${response.statusCode} response: ${response.body}";
      }

      uri = firebaseUri("orders/$id/items.json");
      response = await http.put(uri, body: jsonEncode(order));
      if (response.statusCode != HttpStatus.ok) {
        throw "Unexpected ${response.statusCode} response: ${response.body}";
      }

      _orders.insert(0, order);
      notifyListeners();

      return id;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<CartItem> itemsInOrder({required String id}) {
    final order = _orders.where((order) => order.id == id).single;
    return order.items;
  }
}
