import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import '../adapters/platform_page.dart';
import '../data/meals.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsPage extends StatefulWidget {
  static const route = '/category-meals';

  const CategoryMealsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  List<Meal> displayedMeals = [];
  String title = '';

  bool _stateInitialised = false;

  @override
  void didChangeDependencies() {
    if (_stateInitialised) {
      // return;
    }

    final args = routeArguments(context);
    final categoryId = args['id'];
    title = args['title']!;

    displayedMeals =
        meals.where((m) => m.categoryIds.contains(categoryId)).toList();

    _stateInitialised = true;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final body = ListView.builder(
      itemBuilder: (ctx, index) {
        final meal = displayedMeals[index];

        return MealItem(
          id: meal.id,
          title: meal.name,
          imageUrl: meal.imageUrl,
          preparationTime: meal.preparationTime,
          complexity: meal.complexity,
          affordability: meal.affordability,
          removeFn: _removeItem,
        );
      },
      itemCount: displayedMeals.length,
    );

    return PlatformPage(
      title: '$title Meals',
      content: body,
    );
  }

  void _removeItem(String id) {
    setState(() {
      meals.removeWhere((meal) => meal.id == id);
      print(meals);
    });
  }
}
