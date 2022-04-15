import 'package:flutter/material.dart';

import '../adapters/platform_ink_well.dart';
import '../pages/category_meals.dart';

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

    return PlatformInkWell(
      onPressed: () => _showCategoryMeals(context),
      child: content,
      borderRadius: BorderRadius.circular(15),
    );
  }

  void _showCategoryMeals(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryMealsPage.route, arguments: {
      'id': id,
      'title': title,
    });
  }
}
