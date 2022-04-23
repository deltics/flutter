import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail.dart';

import '../app_theme.dart';
import '../models/favorites.dart';

class ProductGridItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final bool isFavorite;

  const ProductGridItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: theme.gridIconColor,
                ),
                onTap: () => Favorites.of(context, listen: false)
                    .setFavorite(id: id, isFavorite: !isFavorite),
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.shopping_cart,
                  color: theme.gridIconColor,
                ),
                onTap: () {},
              ),
            ),
          ),
          onTap: () => Navigator.of(context).pushNamed(
            ProductDetailPage.route,
            arguments: {'id': id},
          ),
        ),
      ),
    );
  }
}
