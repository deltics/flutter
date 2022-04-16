import 'package:flutter/material.dart';

import '../utils.dart';
import '../../adapters/platform_page.dart';
import '../../data/meals.dart';

class MealDetailPage extends StatelessWidget {
  static const route = '/meal';

  const MealDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = routeArguments(context);
    final mealId = args['id'];
    final title = meals.where((m) => m.id == mealId).single.name;

    return PlatformPage(
      title: title,
      content: Center(child: Text("Details of meal '$mealId'")),
    );
  }
}
