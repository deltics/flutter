import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils.dart';

import '../firebase.dart';
import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [];

  int get count => _items.length;

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAll(BuildContext context) async {
    try {
      final uri = await firebaseUri(context, "products.json");
      final response = await http.get(uri);

      final data = okJsonResponse(response);
      if (data == null) {
        return;
      }

      _items.clear();
      data.forEach((id, item) => _items.add(Product.fromJson(item)));

      _items.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<void> add(BuildContext context, Product p) async {
    try {
      final uri = await firebaseUri(context, "products/${p.id}.json");

      isOk(await http.put(uri, body: jsonEncode(p)));

      _items.add(p);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<void> update(
    BuildContext context, {
    required String id,
    required Product using,
  }) async {
    var itemIndex = _items.indexWhere((item) => item.id == id);

    final item = _items[itemIndex].withValues(
      title: using.title,
      description: using.description,
      price: using.price,
      imageUrl: using.imageUrl,
    );

    try {
      final uri = await firebaseUri(context, "products/${item.id}.json");

      isOk(await http.put(uri, body: jsonEncode(item)));

      _items[itemIndex] = item;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  List<Product> filtered(bool Function(Product) condition) {
    return _items.where(condition).toList();
  }

  Product? byId(String id) {
    return _items.where((p) => p.id == id).single;
  }

  Future<void> deleteById(
    BuildContext context,
    String id,
  ) async {
    try {
      final uri = await firebaseUri(context, "products/$id.json");

      isOk(await http.delete(uri));

      _items.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  static Products of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<Products>(
      context,
      listen: listen,
    );
  }
}
