import 'package:flutter/material.dart';

import '../models/cart.dart';

class ShoppingCartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const ShoppingCartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Are you sure?"),
            content:
                Text("Do you want to remove $quantity x $title from the cart?"),
            actions: [
              TextButton(
                child: const Text("YES"),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
              TextButton(
                child: const Text("NO"),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => Cart.of(context, listen: false)
          .remove(productId: productId, price: price),
      child: Card(
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
      ),
    );
  }
}
