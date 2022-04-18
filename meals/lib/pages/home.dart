import 'package:flutter/material.dart';
import 'package:meals/adapters/platform_tabbed_page.dart';
import 'package:meals/pages/tabs/categories.dart';

import 'tabs/favorite_meals.dart';

class HomePage extends StatelessWidget {
  static const route = '/';

  const HomePage({Key? key}) : super(key: key);

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
        content: const FavoriteMealsTab(),
      ),
    ];

    return PlatformTabbedPage(
      title: 'Meals',
      tabs: tabs,
    );
  }
}
