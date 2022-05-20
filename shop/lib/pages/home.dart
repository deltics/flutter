import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/adapters/platform_page.dart';

import '../app.dart';
import '../adapters/platform_tabbed_page.dart';
import '../models/cart.dart';
import '../models/favorites.dart';
import '../models/products.dart';
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
  var _isLoading = true;

  Future<void> _refresh(BuildContext context) async {
    await Products.of(context, listen: false).fetchAll();
  }

  @override
  void initState() {
    super.initState();

    // This "Future.delayed" pattern has the effect of deferring execution
    //  of the "then" function until after state initialisation has completed
    //  and "context" is then valid.
    //
    // Without "Future.delayed", the context would be invalid at this point
    //  and the app would crash and burn.

    Future.delayed(Duration.zero)
        .then((_) => _refresh(context)
            .then((_) => Favorites.of(context, listen: false).fetch()))
        .whenComplete(() => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final products = Products.of(context);
    final favorites = Favorites.of(context).ids;

    return PlatformTabbedPage(
      tabs: [
        TabDefinition(
          icon: const Icon(Icons.menu_book),
          title: "Catalog",
          content: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: ProductGrid(
                    products: products.items,
                  ),
                ),
        ),
        TabDefinition(
          icon: const Icon(Icons.favorite),
          title: "Favorites",
          content: ProductGrid(
            products: products.filtered((p) => favorites.contains(p.id)),
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
