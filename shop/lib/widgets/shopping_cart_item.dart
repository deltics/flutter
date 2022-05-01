import 'package:flutter/material.dart';

class ShoppingCartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const ShoppingCartItem({
    Key? key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  price.toStringAsFixed(2),
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text("${price * quantity}"),
          trailing: Text("$quantity x"),
        ),
      ),
    );
  }
}
