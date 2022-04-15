import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/pages/category_meals.dart';

import 'cupertino_ink_well.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.all(15),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.7),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Platform.isIOS
        ? CupertinoInkWell(
            onPressed: () => _showCategoryMeals(context),
            child: content,
          )
        : InkWell(
            onTap: () => _showCategoryMeals(context),
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            child: content,
          );
  }

  void _showCategoryMeals(BuildContext context) {
    Navigator.of(context).pushNamed('/category-meals', arguments: {
      'id': id,
      'title': title,
    });
  }
}
