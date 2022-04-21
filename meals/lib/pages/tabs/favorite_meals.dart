import 'package:flutter/material.dart';
import '../../models/meal.dart';
import '../../widgets/meal_list_view.dart';

class FavoriteMealsTab extends StatelessWidget {
  final List<String> favorites;
  final List<Meal> meals;
  final Function delete;
  final Function setFavorite;

  const FavoriteMealsTab({
    Key? key,
    required this.meals,
    required this.favorites,
    required this.delete,
    required this.setFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MealListView(
      meals: meals,
      favorites: favorites,
      delete: delete,
      setFavorite: setFavorite,
    );
  }
}
