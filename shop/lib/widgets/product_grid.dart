import 'package:flutter/material.dart';
import 'package:shop/widgets/product_grid_item.dart';

import '../models/product.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, idx) => ProductGridItem(
        id: products[idx].id,
        title: products[idx].title,
        imageUrl: products[idx].imageUrl,
      ),
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
