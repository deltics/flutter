import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/data/categories.dart';
import 'package:meals/widgets/category_item.dart';

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

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Categories'),
            ),
            child: SafeArea(child: body),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Categories'),
            ),
            body: SafeArea(child: body),
          );
  }
}
