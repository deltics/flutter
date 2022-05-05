import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../adapters/platform_page.dart';
import '../adapters/platform_tabbed_page.dart';
import '../models/cart.dart';
import '../models/favorites.dart';
import '../models/products.dart';
import '../pages/cart.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';
import '../widgets/shop_app_drawer.dart';
import '../widgets/shopping_cart.dart';

enum PageMode { all, favorites }

class HomePage extends StatefulWidget {
  static const route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _mode = PageMode.all;

  @override
  Widget build(BuildContext context) {
    final products = Products.of(context);
    final favorites = (Platform.isIOS || _mode == PageMode.favorites)
        ? Favorites.of(context).ids
        : null;

    return PlatformTabbedPage(
      tabs: [
        TabDefinition(
          icon: const Icon(Icons.menu_book),
          title: "Catalog",
          content: ProductGrid(
            products: products.items,
          ),
        ),
        TabDefinition(
          icon: const Icon(Icons.favorite),
          title: "Favorites",
          content: ProductGrid(
            products: products.filtered((p) => favorites!.contains(p.id)),
          ),
        ),
        TabDefinition(
          icon: Consumer<Cart>(
            builder: (_, cart, __) => Badge(
              child: const Icon(Icons.shopping_cart),
              value: cart.totalQuantity.toString(),
            ),
          ),
          title: "Cart",
          content: Consumer<Cart>(
            builder: (_, cart, __) => const ShoppingCart(),
          ),
        ),
      ],
      title: "MyShop",
      appRoutes: routes,
      drawer: const ShopAppDrawer(),
    );
  }
}
