import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

import '../adapters/platform_ink_well.dart';

class MealItem extends StatelessWidget {
  final int preparationTime;
  final String imageUrl;
  final String title;
  final MealAffordability affordability;
  final MealComplexity complexity;

  const MealItem({
    Key? key,
    required this.imageUrl,
    required this.preparationTime,
    required this.title,
    required this.affordability,
    required this.complexity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformInkWell(
      onPressed: () => _showMeal(context),
      borderRadius: BorderRadius.circular(15),
      child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ]),
            ],
          )),
    );
  }

  void _showMeal(BuildContext context) {}
}
