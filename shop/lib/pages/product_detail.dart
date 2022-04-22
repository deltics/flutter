import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../utils.dart';
import '../app_theme.dart';
import '../adapters/platform_page.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = "/product";

  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = routeArguments(context);
    final id = args['id'];

    final products = Provider.of<ProductsProvider>(context).items;
    final product = products.where((p) => p.id == id).single;

    return PlatformPage(
      theme: theme,
      title: 'Product',
      content: SizedBox(
        child: Text(product.title),
      ),
    );
  }
}
