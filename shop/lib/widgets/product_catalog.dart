import 'package:flutter/material.dart';
import 'package:shop/pages/edit_product.dart';

import '../models/product.dart';
import '../models/products.dart';

class ProductCatalog extends StatelessWidget {
  final List<Product> items;

  const ProductCatalog({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return Column(
          children: [
            ProductCatalogItem(
              id: item.id,
              title: item.title,
              imageUrl: item.imageUrl,
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}

class ProductCatalogItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductCatalogItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: colors.primary,
              onPressed: () => Navigator.of(context).pushNamed(
                EditProductPage.route,
                arguments: {
                  "id": id,
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: colors.error,
              onPressed: () =>
                  Products.of(context, listen: false).deleteById(id),
            ),
          ],
        ),
      ),
    );
  }
}
