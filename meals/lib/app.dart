import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/meal_detail.dart';
import 'pages/category_meals.dart';
import 'pages/filters.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = {
      HomePage.route: (ctx) => const HomePage(),
      CategoryMealsPage.route: (ctx) => const CategoryMealsPage(),
      MealDetailPage.route: (ctx) => const MealDetailPage(),
      FiltersPage.route: (ctx) => const FiltersPage(),
    };

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
