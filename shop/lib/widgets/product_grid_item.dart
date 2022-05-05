import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/product_detail.dart';
import 'package:shop/widgets/added_to_cart_snackbar.dart';

import '../models/cart.dart';
import '../models/favorites.dart';

class ProductGridItem extends StatelessWidget {
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
              imageUrl,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(title),
              leading: GestureDetector(
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: colorScheme.secondary,
                ),
                onTap: () => Favorites.of(context, listen: false)
                    .setFavorite(id: id, isFavorite: !isFavorite),
              ),
              trailing: Consumer<Cart>(
                builder: (context, cart, __) => GestureDetector(
                    child: Icon(
                      Icons.shopping_cart,
                      color: colorScheme.secondary,
                    ),
                    onTap: () {
                      cart.add(productId: id, price: price);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(AddedToCartSnackBar.build(
                              context: context,
                              action: () => cart.remove(
                                    productId: id,
                                    price: price,
                                  )));
                    }),
              ),
            ),
          ),
          onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
            ProductDetailPage.route,
            arguments: {'id': id},
          ),
        ),
      ),
    );
  }
}
