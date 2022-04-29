import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/products.dart';
import '../utils.dart';
import '../app_theme.dart';
import '../adapters/platform_page.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = "/product";

  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = routeArguments(context)['id'];

    final cart = Cart.of(context: context);
    final product = Products.of(context).byId(id!)!;

    final content = SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  cart.add(
                    productId: product.id,
                    price: product.price,
                  );
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  child: Row(children: const [
                    Icon(Icons.shopping_cart),
                    Text("Add to cart"),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              )),
        ],
      ),
    );

    return PlatformPage(
      theme: theme,
      title: 'Product',
      content: SizedBox(
        child: content,
      ),
    );
  }
}
