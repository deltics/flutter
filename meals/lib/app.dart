import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/widgets/category_item.dart';

import 'pages/categories.dart';
import 'pages/category_meals.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Meals',
            theme: const CupertinoThemeData(
              primaryColor: Colors.orange,
            ),
            home: const CategoriesPage(),
            routes: {
              '/categories': (ctx) => const CategoriesPage(),
              '/category-meals': (ctx) => const CategoryMealsPage(),
            },
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
            home: const CategoriesPage(),
          );
  }
}
