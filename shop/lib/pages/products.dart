import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/product_grid.dart';

import '../adapters/platform_page.dart';
import '../app_theme.dart';
import '../models/products.dart';

class ProductsPage extends StatelessWidget {
  static const route = '/products';

  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Products.of(context).items;

    return PlatformPage(
      theme: theme,
      title: 'Products',
      content: ProductGrid(products: products),
    );
  }
}
