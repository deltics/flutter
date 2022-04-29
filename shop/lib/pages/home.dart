import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../adapters/platform_page.dart';
import '../adapters/platform_tabbed_page.dart';
import '../app.dart';
import '../app_theme.dart';
import '../models/cart.dart';
import '../models/favorites.dart';
import '../models/products.dart';

import '../pages/cart.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';
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

    return Platform.isIOS
        ? PlatformTabbedPage(
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
          )
        : PlatformPage(
            theme: theme,
            title: 'Products',
            actions: [
              Consumer<Cart>(
                builder: (_, cart, __) => Badge(
                  child: GestureDetector(
                    child: const Icon(Icons.shopping_cart),
                    onTap: () =>
                        Navigator.of(context).pushNamed(CartPage.route),
                  ),
                  value: cart.totalQuantity.toString(),
                ),
              ),
            ],
            floatingAction: PageAction(
                child: PopupMenuButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.white),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text('All Products'),
                      value: PageMode.all,
                    ),
                    const PopupMenuItem(
                      child: Text('Favorites'),
                      value: PageMode.favorites,
                    ),
                  ],
                  onSelected: (PageMode value) => setState(() => _mode = value),
                ),
                onPressed: () => {}),
            content: ProductGrid(
              products: (_mode == PageMode.favorites)
                  ? products.filtered((p) => favorites!.contains(p.id)).toList()
                  : products.items,
            ),
          );
  }
}
