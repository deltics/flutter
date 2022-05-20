import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'added_to_cart_snackbar.dart';
import '../models/cart.dart';
import '../models/favorites.dart';
import '../models/product.dart';
import '../pages/product_detail.dart';

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
          price: product.price,
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

class ProductGridItem extends StatefulWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  const ProductGridItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isFavorite,
    required this.price,
  }) : super(key: key);

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  var _isFavoriteChanging = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6), //color of shadow
            spreadRadius: 3, //spread radius
            blurRadius: 8, // blur radius
            offset: const Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          child: GridTile(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(widget.title),
              leading: _isFavoriteChanging
                  ? const SizedBox.square(
                      dimension: 26, child: CircularProgressIndicator())
                  : GestureDetector(
                      child: Icon(
                        widget.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: colorScheme.secondary,
                        size: 26,
                      ),
                      onTap: () {
                        setState(() => _isFavoriteChanging = true);
                        Favorites.of(context, listen: false)
                            .setFavorite(
                                id: widget.id, isFavorite: !widget.isFavorite)
                            .then((_) =>
                                setState(() => _isFavoriteChanging = false));
                      },
                    ),
              trailing: Consumer<Cart>(
                builder: (context, cart, __) => GestureDetector(
                    child: Icon(
                      Icons.shopping_cart,
                      color: colorScheme.secondary,
                    ),
                    onTap: () {
                      cart.add(
                        productId: widget.id,
                        title: widget.title,
                        price: widget.price,
                      );

                      ScaffoldMessenger.of(context)
                          .showSnackBar(AddedToCartSnackBar.build(
                              context: context,
                              action: () => cart.remove(
                                    productId: widget.id,
                                    price: widget.price,
                                  )));
                    }),
              ),
            ),
          ),
          onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
            ProductDetailPage.route,
            arguments: {'id': widget.id},
          ),
        ),
      ),
    );
  }
}
