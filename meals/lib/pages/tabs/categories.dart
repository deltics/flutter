import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/categories.dart';
import '../../../widgets/category_item.dart';

class CategoriesTab extends StatelessWidget {
  static const route = '/categories';

  const CategoriesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: categories
          .map((c) => CategoryItem(
                id: c.id,
                title: c.title,
                color: c.color,
              ))
          .toList(),
    );
  }
}
