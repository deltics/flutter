import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../adapters/platform_tabbed_page.dart';
import '../models/auth.dart';
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
  Future<void> _refresh(BuildContext context) async {
    await Products.of(
      context,
      listen: false,
    ).fetchAll(context, forceFetch: true);
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
    //
    // The FutureBuilder alternative removes the need to track loading state
    //  and enables us to isolate any provider consumers (listeners) to the
    //  affected branch of the widget tree.

    // Future.delayed(Duration.zero)
    //     .then((_) => _refresh(context)
    //         .then((_) => Favorites.of(context, listen: false).fetch()))
    //     .whenComplete(() => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Auth.of(context);

    if (!auth.isSignedIn) {
      // Return a dummy container unless/until we
      //  have successfully signed in
      return Container();
    }

    final products = Products.of(context);
    final favorites = Favorites.of(context)!.ids;

    return PlatformTabbedPage(
      tabs: [
        TabDefinition(
          icon: const Icon(Icons.menu_book),
          title: "Catalog",
          content: RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: const ProductGrid(
              mode: ProductGridMode.all,
            ),
          ),
        ),
        TabDefinition(
          icon: const Icon(Icons.favorite),
          title: "Favorites",
          content: const ProductGrid(
            mode: ProductGridMode.favorites,
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
