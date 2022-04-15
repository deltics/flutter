import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryMealsPage extends StatelessWidget {
  static const route = '/category-meals';

  const CategoryMealsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = args['title'];
    final body = Container();

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('$title Meals'),
            ),
            child: SafeArea(child: body),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('$title Meals'),
            ),
            body: SafeArea(child: body),
          );
  }
}
