import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../firebase.dart';
import '../utils.dart';
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

  Order.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        totalAmount = json["totalAmount"],
        datetime = DateTime.parse(json["datetime"]),
        items = (json["items"] as List<dynamic>)
            .map((item) => CartItem.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalAmount": totalAmount,
        "datetime": DateFormat('yyyy-MM-dd hh:mm:ss').format(datetime),
        "items": items.map((item) => item.toJson()).toList(),
      };
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

  Future<String> create(
    BuildContext context, {
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
      var uri = await firebaseUri(context, "orders/$id.json");

      isOk(await http.put(uri, body: jsonEncode(order)));

      _orders.insert(0, order);
      notifyListeners();

      return id;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<void> fetchAll(BuildContext context) async {
    try {
      var uri = await firebaseUri(context, "orders.json");
      var response = await http.get(uri);
      final data = okJsonResponse(response);
      if (data == null) {
        return;
      }

      _orders.clear;
      data.forEach((id, item) => _orders.add(Order.fromJson(item)));

      _orders.sort((a, b) => b.datetime.compareTo(a.datetime));

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  List<CartItem> itemsInOrder({required String id}) {
    final order = _orders.where((order) => order.id == id).single;
    return order.items;
  }
}
