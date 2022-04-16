import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../adapters/platform_page.dart';
import '../../data/categories.dart';
import '../../widgets/category_item.dart';

class CategoriesPage extends StatelessWidget {
  static const route = '/categories';

  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var body = GridView(
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

    return PlatformPage(
      title: 'Categories',
      content: body,
    );
  }
}
