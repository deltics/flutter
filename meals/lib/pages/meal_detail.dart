import 'dart:io';

import 'package:flutter/material.dart';

import '../utils.dart';
import '../../adapters/platform_list_tile.dart';
import '../../adapters/platform_page.dart';
import '../../data/meals.dart';

class MealDetailPage extends StatelessWidget {
  static const route = '/meal';

  const MealDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = routeArguments(context);
    final mealId = args['id'];
    final meal = meals.where((m) => m.id == mealId).single;

    final body = Column(children: [
      SizedBox(
        height: 200,
        width: double.infinity,
        child: Image(
          image: NetworkImage(meal.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Text(
            'Ingredients',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline6,
          )),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 150,
        width: double.infinity,
        child: ListView.builder(
          itemCount: meal.ingredients.length,
          itemBuilder: (ctx, index) => Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromRGBO(225, 225, 225, 1), width: 1))),
            child: Text(
              meal.ingredients[index],
            ),
          ),
        ),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Text(
            'Steps',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline6,
          )),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 280,
        width: double.infinity,
        child: ListView.builder(
          itemCount: meal.steps.length,
          itemBuilder: (ctx, index) => Column(children: [
            PlatformListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(
                meal.steps[index],
              ),
            ),
            const Divider()
          ]),
        ),
      ),
    ]);

    return PlatformPage(
      title: meal.name,
      content: body,
      action: PageAction(
        icon: const Icon(Icons.delete),
        onPressed: (ctx) {
          print("About to pop...");
          Navigator.of(context).pop(mealId);
        },
      ),
    );
  }
}
