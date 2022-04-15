enum MealAffordability {
  cheap,
  reasonable,
  luxury,
}
enum MealComplexity {
  simple,
  moderate,
  challenging,
  difficult,
}

class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> categoryIds;
  final int preparationTime;
  final MealAffordability affordability;
  final MealComplexity complexity;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.categoryIds,
    required this.preparationTime,
    required this.affordability,
    required this.complexity,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
