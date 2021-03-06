import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/pages/meal_detail.dart';

import '../adapters/platform_ink_well.dart';

class MealItem extends StatelessWidget {
  final String id;
  final int preparationTime;
  final String imageUrl;
  final String title;
  final MealAffordability affordability;
  final MealComplexity complexity;
  final bool isFavorite;
  final Function removeFn;
  final Function favoriteFn;

  const MealItem({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.preparationTime,
    required this.title,
    required this.affordability,
    required this.complexity,
    required this.isFavorite,
    required this.removeFn,
    required this.favoriteFn,
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
                Positioned(
                  right: 20,
                  top: 20,
                  child: GestureDetector(
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                    ),
                    onTap: () => favoriteFn(id: id, isFavorite: !isFavorite),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    width: 300,
                    color: Colors.black54,
                    child: Text(title,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      const Icon(Icons.schedule_outlined),
                      const SizedBox(width: 6),
                      Text("$preparationTime"),
                    ]),
                    Row(children: [
                      const Icon(Icons.work_outline),
                      const SizedBox(width: 6),
                      Text(describeEnum(complexity)),
                    ]),
                    Row(children: [
                      const Icon(Icons.attach_money_outlined),
                      const SizedBox(width: 2),
                      Text(describeEnum(affordability)),
                    ]),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _showMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailPage.route,
      arguments: {
        'id': id,
      },
    ).then(
      (result) {
        if (result != null) {
          removeFn(result);
        }
      },
    );
  }
}
