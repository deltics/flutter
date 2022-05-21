import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../firebase.dart';
import 'product.dart';

class Products with ChangeNotifier {
  final _uri = firebaseUri("products.json");

  final _items = [
    const Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    const Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    const Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    const Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  int get count => _items.length;

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAll() async {
    try {
      final response = await http.get(_uri);

      final data = jsonDecode(response.body) as Map<String, dynamic>?;
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

  Future<void> add(Product p) async {
    try {
      final uri = firebaseUri("products/${p.id}.json");
      final response = await http.put(uri, body: jsonEncode(p));
      if (response.statusCode != HttpStatus.ok) {
        throw "Unexpected ${response.statusCode} response: ${response.body}";
      }

      _items.add(p);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<void> update({
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
      final uri = firebaseUri("products/${item.id}.json");
      final response = await http.put(uri, body: jsonEncode(item));
      if (response.statusCode != HttpStatus.ok) {
        throw "Unexpected ${response.statusCode} response: ${response.body}";
      }

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

  Future<void> deleteById(String id) async {
    try {
      final uri = firebaseUri("products/$id.json");
      final response = await http.delete(uri);

      if (response.statusCode != HttpStatus.ok) {
        throw "Unexpected ${response.statusCode} response: ${response.body}";
      }

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
