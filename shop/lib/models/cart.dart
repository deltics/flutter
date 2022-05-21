import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String product;
  final String productId;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  CartItem.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        productId = json["productId"],
        product = json["product"],
        price = json["price"],
        quantity = json["quantity"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "productId": productId,
        "quantity": quantity,
        "price": price,
      };
}

class Cart with ChangeNotifier {
  static Cart of(BuildContext context, {bool listen = true}) =>
      Provider.of<Cart>(context, listen: listen);

  final Map<String, CartItem> _items = {};
  double _totalAmount = 0;
  int _totalQuantity = 0;

  int get numberOfProducts => _items.length;
  double get totalAmount => _totalAmount;
  int get totalQuantity => _totalQuantity;

  List<CartItem> get items {
    final List<CartItem> result = [];

    _items.forEach((_, item) => result.add(item));

    return result;
  }

  void add({
    required String productId,
    required String title,
    required double price,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          productId: productId,
          product: title,
          quantity: existing.quantity + 1,
          price: price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: const Uuid().v4(),
          productId: productId,
          product: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    _totalAmount += price;
    _totalQuantity++;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _totalAmount = 0;
    _totalQuantity = 0;
    notifyListeners();
  }

  CartItem itemByIndex(int index) {
    return _items.values.elementAt(index);
  }

  void remove({
    required String productId,
    required double price,
  }) {
    if (!_items.containsKey(productId)) {
      return;
    }
    final item = _items[productId]!;
    final quantityToRemove = item.quantity;
    final priceToRemove = item.price * quantityToRemove;
    _items.remove(productId);

    _totalAmount -= priceToRemove;
    _totalQuantity -= quantityToRemove;

    if (_totalAmount < 0) {
      _totalAmount = 0;
    }
    notifyListeners();
  }

  bool contains({required String productId}) {
    return _items.containsKey(productId);
  }

  int? productQuantity({required String productId}) {
    return _items[productId]?.quantity;
  }
}
