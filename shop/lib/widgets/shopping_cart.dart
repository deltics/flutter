import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/orders.dart';
import '../models/products.dart';
import 'shopping_cart_item.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Cart.of(context);

    final products = Products.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    final total = Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Chip(
                label: Text(cart.totalAmount.toStringAsFixed(2),
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                    )),
                backgroundColor: colorScheme.primary,
              ),
              cart.totalQuantity > 0 ? const SizedBox(width: 10) : Container(),
              cart.totalQuantity > 0
                  ? TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text("CHECK-OUT"),
                      onPressed: () async {
                        final orders = Orders.of(context, listen: false)!;
                        final id = await orders.create(context, cart: cart);

                        cart.clear();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Order created"),
                            action: SnackBarAction(
                              textColor: colorScheme.secondary,
                              label: "UNDO",
                              onPressed: () {
                                final items = orders.itemsInOrder(id: id);

                                orders.cancel(id: id);

                                for (var item in items) {
                                  cart.add(
                                    productId: item.productId,
                                    title: item.product,
                                    price: item.price,
                                  );
                                }
                              },
                            )));
                      },
                    )
                  : Container(),
            ],
          ),
        ));

    final items = ListView.builder(
      itemCount: cart.numberOfProducts,
      itemBuilder: (_, index) {
        final item = cart.itemByIndex(index);
        final product = products.byId(item.productId)!;

        return ShoppingCartItem(
          id: item.id,
          productId: product.id,
          title: product.title,
          price: product.price,
          quantity: item.quantity,
        );
      },
    );

    return Column(
      children: [
        total,
        const SizedBox(height: 10),
        cart.totalQuantity > 0
            ? Expanded(child: items)
            : const Center(
                child: Text(
                "Shopping Cart is empty",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
      ],
    );
  }
}
