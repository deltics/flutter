import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/edit_product.dart';
import 'package:shop/widgets/shop_app_drawer.dart';

import '../adapters/platform_page.dart';
import '../models/products.dart';
import '../widgets/product_catalog.dart';

class ProductsPage extends StatelessWidget {
  static const route = "/products";

  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformPage(
      title: "Products",
      drawer: const ShopAppDrawer(),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () =>
              Navigator.of(context).pushNamed(EditProductPage.route),
        ),
      ],
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<Products>(
          builder: (_, products, __) => ProductCatalog(
            items: products.items,
          ),
        ),
      ),
    );
  }
}
