import 'package:flutter/material.dart';

import 'tabs/categories.dart';
import 'tabs/favorite_meals.dart';

import '../adapters/platform_tabbed_page.dart';
import '../models/meal.dart';

class HomePage extends StatelessWidget {
  static const route = '/';

  final List<Meal> favoriteMeals;
  final Function delete;
  final Function setFavorite;

  const HomePage({
    Key? key,
    required this.favoriteMeals,
    required this.delete,
    required this.setFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TabDefinition> tabs = [
      TabDefinition(
        icon: const Icon(Icons.category),
        title: 'Categories',
        content: const CategoriesTab(),
      ),
      TabDefinition(
        icon: const Icon(Icons.favorite),
        title: 'Favorites',
        content: FavoriteMealsTab(
          meals: favoriteMeals,
          favorites: favoriteMeals.map((meal) => meal.id).toList(),
          delete: delete,
          setFavorite: setFavorite,
        ),
      ),
    ];

    return PlatformTabbedPage(
      title: 'Meals',
      tabs: tabs,
    );
  }
}
