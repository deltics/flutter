import 'package:flutter/material.dart';

import '../adapters/platform_chip.dart';
import '../models/cart.dart';
import '../models/products.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Cart.of(context: context);

    if (cart.totalQuantity == 0) {
      return const Center(
          child: Text(
        "Shopping Cart is empty",
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    }

    final products = Products.of(context);
    final List<Widget> items = [];

    items.addAll([
      Container(
        padding: const EdgeInsets.only(
          left: 60,
          right: 60,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '\$${cart.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const Divider()
    ]);

    items.addAll(cart.items.map((item) {
      final product = products.byId(item.productId);

      return SizedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image(image: NetworkImage(product!.imageUrl)),
              ),
              const SizedBox(width: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 150,
                  minWidth: 150,
                ),
                child: Expanded(child: Text(product.title)),
              ),
              SizedBox(
                  width: 20,
                  child: Center(
                      child: Text(
                    "${item.quantity}",
                    textAlign: TextAlign.center,
                  ))),
              Expanded(
                child: Text(
                  "\$${(item.quantity * product.price).toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                child: const SizedBox(
                  width: 20,
                  child: Icon(Icons.delete, color: Colors.red),
                ),
                onTap: () => cart.remove(
                  productId: item.productId,
                  price: product.price,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
    }));

    return Column(
      children: items,
    );
  }
}
