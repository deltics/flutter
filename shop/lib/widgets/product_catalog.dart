import 'package:flutter/material.dart';

import '../models/product.dart';

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
  final String title;
  final String imageUrl;

  const ProductCatalogItem({
    Key? key,
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
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: colors.error,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
