import 'package:flutter/material.dart';

import '../adapters/platform_page.dart';
import '../widgets/shopping_cart.dart';

class CartPage extends StatelessWidget {
  static const route = "/cart";

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PlatformPage(
      title: "Cart",
      content: ShoppingCart(),
    );
  }
}
