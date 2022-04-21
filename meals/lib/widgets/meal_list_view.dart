import 'package:flutter/material.dart';

import '../models/meal.dart';
import 'meal_item.dart';

class MealListView extends StatelessWidget {
  final List<Meal> meals;
  final List<String> favorites;
  final Function setFavorite;
  final Function delete;

  const MealListView(
      {Key? key,
      required this.meals,
      required this.favorites,
      required this.delete,
      required this.setFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final meal = meals[index];

        return MealItem(
          id: meal.id,
          title: meal.name,
          imageUrl: meal.imageUrl,
          preparationTime: meal.preparationTime,
          complexity: meal.complexity,
          affordability: meal.affordability,
          isFavorite: favorites.contains(meal.id),
          favoriteFn: setFavorite,
          removeFn: delete,
        );
      },
      itemCount: meals.length,
    );
  }
}
