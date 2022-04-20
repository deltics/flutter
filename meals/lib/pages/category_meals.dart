import 'package:flutter/material.dart';
import 'package:meals/pages/filters.dart';

import '../utils.dart';
import '../adapters/platform_page.dart';
import '../data/meals.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsPage extends StatefulWidget {
  static const route = '/category-meals';

  final List<String> favoriteIds;
  final List<Meal> meals;
  final Function updateMealsFn;
  final Function setFavoriteFn;

  const CategoryMealsPage({
    Key? key,
    required this.meals,
    required this.favoriteIds,
    required this.updateMealsFn,
    required this.setFavoriteFn,
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
    // Cannot use initState for this initialisation as there is no valid context
    //  when initState() is called.  But didChangeDependencies is called more often,
    //  so we have to manually ensure we run-once once, via the _stateInitialised flag

    if (_stateInitialised) {
      return;
    }

    final args = routeArguments(context);
    final categoryId = args['id'];
    title = args['title']!;

    displayedMeals =
        widget.meals.where((m) => m.categoryIds.contains(categoryId)).toList();

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
          isFavorite: widget.favoriteIds.contains(meal.id),
          favoriteFn: widget.setFavoriteFn,
          removeFn: _removeItem,
        );
      },
      itemCount: displayedMeals.length,
    );

    return PlatformPage(
        title: '$title Meals',
        content: body,
        action: PageAction(
          icon: const Icon(Icons.filter_alt),
          onPressed: (_) => {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(FiltersPage.route)
                .then((_) => widget.updateMealsFn())
          },
        ));
  }

  void _removeItem(String id) {
    setState(() {
      // Ideally we'd remove from meals and let state updates take care
      //  of updating displayedMeals, but dependencies don't change
      //  when 'pop'ping back to the page so we need to manually remove
      //  from both displayedMeals and the source meals list.

      meals.removeWhere((meal) => meal.id == id);
      widget.updateMealsFn();
    });
  }
}
