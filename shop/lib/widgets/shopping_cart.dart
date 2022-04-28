import 'package:flutter/material.dart';

import '../adapters/platform_chip.dart';
import '../models/cart.dart';
import '../models/products.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Cart.of(context: context);
    final products = Products.of(context);
    final List<Widget> items = [];

    items.addAll(cart.items.map((item) {
      final product = products.byId(item.productId);

      return SizedBox(
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image(image: NetworkImage(product!.imageUrl)),
            ),
            Expanded(child: Text(product.title)),
            Text("${item.quantity}")
          ],
        ),
      );
    }));

    items.add(Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Text('Total'),
              const SizedBox(width: 10),
              PlatformChip(
                label: Text('${cart.totalAmount}'),
              ),
            ],
          ),
        )));

    return Column(
      children: items,
    );
  }
}
