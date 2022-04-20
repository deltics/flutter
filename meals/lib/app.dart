import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/meals.dart';
import 'models/meal.dart';
import 'pages/home.dart';
import 'pages/meal_detail.dart';
import 'pages/category_meals.dart';
import 'pages/filters.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {};

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _favoriteIds = [];
  List<Meal> _meals = meals;
  final List<MealSuitability> _mealFilter = [
    MealSuitability.glutenFree,
    MealSuitability.lactoseFree,
    MealSuitability.vegan,
    MealSuitability.vegetarian,
  ];

  void _applyFilter({
    required MealSuitability suitability,
    required bool show,
  }) {
    // setState(() {
    if (show && !_mealFilter.contains(suitability)) {
      _mealFilter.add(suitability);
    } else if (!show && _mealFilter.contains(suitability)) {
      _mealFilter.remove(suitability);
    }
    _applyFilters();
    // });
  }

  void _applyFilters() {
    setState(() {
      _meals = meals.where((meal) {
        if (_mealFilter.contains(MealSuitability.glutenFree) &&
            !meal.isGlutenFree) {
          return false;
        }
        if (_mealFilter.contains(MealSuitability.lactoseFree) &&
            !meal.isLactoseFree) {
          return false;
        }
        if (_mealFilter.contains(MealSuitability.vegan) && !meal.isVegan) {
          return false;
        }
        if (_mealFilter.contains(MealSuitability.vegetarian) &&
            !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _setFavorite({
    required String id,
    required bool isFavorite,
  }) {
    setState(() {
      if (isFavorite) {
        if (!_favoriteIds.contains(id)) {
          _favoriteIds.add(id);
        }
      } else {
        if (_favoriteIds.contains(id)) {
          _favoriteIds.remove(id);
        }
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = {
      HomePage.route: (ctx) => const HomePage(),
      CategoryMealsPage.route: (ctx) => CategoryMealsPage(
            key: ValueKey(_meals.hashCode),
            meals: _meals,
            favoriteIds: _favoriteIds,
            updateMealsFn: _applyFilters,
            setFavoriteFn: _setFavorite,
          ),
      MealDetailPage.route: (ctx) => const MealDetailPage(),
      FiltersPage.route: (ctx) => FiltersPage(
            filters: _mealFilter,
            applyFilterFn: _applyFilter,
          ),
    };

    appRoutes = routes;

    return Platform.isIOS
        ? CupertinoApp(
            title: 'Meals',
            theme: const CupertinoThemeData(
              primaryColor: Colors.orange,
            ),
            initialRoute: HomePage.route,
            routes: routes,
          )
        : MaterialApp(
            title: 'Meals',
            theme: ThemeData(
                primarySwatch: Colors.orange,
                fontFamily: 'Raleway',
                textTheme: ThemeData.light().textTheme.copyWith(
                      bodyText1: const TextStyle(
                        color: Color.fromRGBO(20, 51, 51, 1),
                      ),
                      bodyText2: const TextStyle(
                        color: Color.fromRGBO(20, 51, 51, 1),
                      ),
                      headline6: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
            initialRoute: HomePage.route,
            routes: routes,
          );
  }
}
