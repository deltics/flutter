import 'package:flutter/material.dart';
import 'package:meals/pages/filters.dart';
import 'package:meals/widgets/meal_list_view.dart';

import '../utils.dart';
import '../adapters/platform_page.dart';
import '../data/meals.dart';
import '../models/meal.dart';

class CategoryMealsPage extends StatefulWidget {
  static const route = '/category-meals';

  final List<String> favoriteIds;
  final List<Meal> meals;
  final Function deleteFn;
  final Function updateMealsFn;
  final Function setFavoriteFn;

  const CategoryMealsPage({
    Key? key,
    required this.meals,
    required this.favoriteIds,
    required this.deleteFn,
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
    return PlatformPage(
        title: '$title Meals',
        content: MealListView(
          meals: displayedMeals,
          favorites: widget.favoriteIds,
          delete: widget.deleteFn,
          setFavorite: widget.setFavoriteFn,
        ),
        action: PageAction(
          icon: const Icon(Icons.filter_alt),
          onPressed: (_) => {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(FiltersPage.route)
                .then((_) => widget.updateMealsFn())
          },
        ));
  }
}
