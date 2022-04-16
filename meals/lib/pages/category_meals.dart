import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import '../../adapters/platform_page.dart';
import '../../data/meals.dart';
import '../widgets/meal_item.dart';

class CategoryMealsPage extends StatelessWidget {
  static const route = '/category-meals';

  const CategoryMealsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = routeArguments(context);
    final categoryId = args['id'];
    final categoryTitle = args['title'];

    final categoryMeals =
        meals.where((m) => m.categoryIds.contains(categoryId)).toList();

    final body = ListView.builder(
      itemBuilder: (ctx, index) {
        final meal = categoryMeals[index];

        return MealItem(
          id: meal.id,
          title: meal.name,
          imageUrl: meal.imageUrl,
          preparationTime: meal.preparationTime,
          complexity: meal.complexity,
          affordability: meal.affordability,
        );
      },
      itemCount: categoryMeals.length,
    );

    return PlatformPage(
      title: '$categoryTitle Meals',
      content: body,
    );
  }
}
