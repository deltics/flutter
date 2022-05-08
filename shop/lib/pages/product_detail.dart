import 'package:flutter/material.dart';

import '../utils.dart';
import '../adapters/platform_page.dart';
import '../models/cart.dart';
import '../models/products.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = "/product";

  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = routeArguments(context)['id'];

    final cart = Cart.of(context);
    final product = Products.of(context).byId(id!)!;

    final content = //SingleChildScrollView(
        //child:
        Column(
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
        SizedBox(
          width: double.infinity,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(
                  color: Colors.grey[800],
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
                  child: Row(children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text("Add to cart",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor,
                        )),
                  ]),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black,
              ),
              softWrap: true,
            )),
      ],
//      ),
    );

    return PlatformPage(
      title: 'Product',
      content: SizedBox(
        child: content,
      ),
    );
  }
}
