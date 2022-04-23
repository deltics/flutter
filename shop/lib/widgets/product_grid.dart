import 'package:flutter/material.dart';
import 'package:shop/widgets/product_grid_item.dart';

import '../models/favorites.dart';
import '../models/product.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = Favorites.of(context);

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, idx) {
        final product = products[idx];

        return ProductGridItem(
          id: product.id,
          title: product.title,
          imageUrl: product.imageUrl,
          isFavorite: favorites.isFavorite(product.id),
        );
      },
      // The delegate determines the appearance of the grid itself.
      //  This delegate determines a fixed number of "cross axis elements"
      //  - i.e. columns.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
