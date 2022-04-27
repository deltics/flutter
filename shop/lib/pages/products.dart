import 'package:flutter/material.dart';
import 'package:shop/widgets/product_grid.dart';

import '../adapters/platform_page.dart';
import '../adapters/platform_popup_menu.dart';
import '../app_theme.dart';
import '../models/favorites.dart';
import '../models/products.dart';

enum ProductsFilter { all, favorites }

class ProductsPage extends StatefulWidget {
  static const route = '/products';

  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  var filter = ProductsFilter.all;

  @override
  Widget build(BuildContext context) {
    final favorites = Favorites.of(context).ids;

    return PlatformPage(
      theme: theme,
      title: 'Products',
      actionWidget: PlatformPopupMenu(
        icon: const Icon(Icons.filter),
        items: [
          PlatformMenuItem(
            child: const Text('All Products'),
            value: ProductsFilter.all,
          ),
          PlatformMenuItem(
            child: const Text('Favorites'),
            value: ProductsFilter.favorites,
          ),
        ],
        onSelected: (ProductsFilter value) => setState(() => filter = value),
      ),
      content: ProductGrid(
        products: filter == ProductsFilter.favorites
            ? Products.of(context).filtered((p) => favorites.contains(p.id))
            : Products.of(context).items,
      ),
    );
  }
}
