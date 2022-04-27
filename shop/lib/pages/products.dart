import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop/widgets/product_grid.dart';

import '../adapters/platform_page.dart';
import '../adapters/platform_tabbed_page.dart';
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
    final products = Products.of(context);
    final favorites = (Platform.isIOS || filter == ProductsFilter.favorites)
        ? Favorites.of(context).ids
        : null;

    return Platform.isIOS
        ? PlatformTabbedPage(
            tabs: [
              TabDefinition(
                icon: const Icon(Icons.factory),
                title: "All",
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
            ],
            title: "Products",
            appRoutes: null,
          )
        : PlatformPage(
            theme: theme,
            title: 'Products',
            action: PageAction(
                child: PopupMenuButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.white),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text('All Products'),
                      value: ProductsFilter.all,
                    ),
                    const PopupMenuItem(
                      child: Text('Favorites'),
                      value: ProductsFilter.favorites,
                    ),
                  ],
                  onSelected: (ProductsFilter value) =>
                      setState(() => filter = value),
                ),
                onPressed: () => {}),
            content: ProductGrid(
              products: (filter == ProductsFilter.favorites)
                  ? products.filtered((p) => favorites!.contains(p.id)).toList()
                  : products.items,
            ),
          );
  }
}
