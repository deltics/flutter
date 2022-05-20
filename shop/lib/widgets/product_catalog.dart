import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/products.dart';
import '../pages/edit_product.dart';

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

class ProductCatalogItem extends StatefulWidget {
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
  State<ProductCatalogItem> createState() => _ProductCatalogItemState();
}

class _ProductCatalogItemState extends State<ProductCatalogItem> {
  var _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
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
                  "id": widget.id,
                },
              ),
            ),
            _isDeleting
                ? const CircularProgressIndicator()
                : IconButton(
                    icon: const Icon(Icons.delete),
                    color: colors.error,
                    onPressed: () {
                      setState(() => _isDeleting = true);
                      Products.of(context, listen: false)
                          .deleteById(widget.id)
                          .then((_) => setState(() => _isDeleting = false));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
