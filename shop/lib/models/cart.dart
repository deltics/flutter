import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem {
  final String id;
  final String productId;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  static Cart of({required BuildContext context, bool listen = true}) =>
      Provider.of<Cart>(context);

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
    required double price,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          productId: productId,
          quantity: existing.quantity + 1,
          price: price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: UniqueKey().toString(),
          productId: productId,
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

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existing) => CartItem(
            id: existing.id,
            productId: productId,
            quantity: existing.quantity - 1,
            price: price),
      );
    } else {
      _items.remove(productId);
    }
    _totalAmount -= price;
    _totalQuantity--;
    notifyListeners();
  }

  bool contains({required String productId}) {
    return _items.containsKey(productId);
  }

  int? productQuantity({required String productId}) {
    return _items[productId]?.quantity;
  }
}
