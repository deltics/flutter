import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../utils.dart';
import '../app_theme.dart';
import '../adapters/platform_page.dart';

class ProductDetailPage extends StatelessWidget {
  static const route = "/product";

  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = routeArguments(context)['id'];

    final product = Products.of(context).byId(id!);

    return PlatformPage(
      theme: theme,
      title: 'Product',
      content: SizedBox(
        child: Text(product!.title),
      ),
    );
  }
}
