import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryMealsPage extends StatelessWidget {
  const CategoryMealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = Container();

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
