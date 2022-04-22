import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/product_grid.dart';

import '../adapters/platform_page.dart';
import '../app_theme.dart';
import '../providers/products_provider.dart';

class ProductsPage extends StatelessWidget {
  static const route = '/products';

  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).items;

    return PlatformPage(
      theme: theme,
      title: 'Products',
      content: ProductGrid(products: products),
    );
  }
}
