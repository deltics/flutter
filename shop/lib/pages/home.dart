import 'package:flutter/material.dart';
import 'package:shop/pages/products.dart';

import '../adapters/platform_page.dart';
import '../app_theme.dart';

class HomePage extends StatelessWidget {
  static const route = '/';

  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return PlatformPage(
      theme: theme,
      title: title,
      content: Center(
          child: GestureDetector(
        child: const Icon(
          Icons.factory,
        ),
        onTap: () => Navigator.of(context).pushNamed(ProductsPage.route),
      )),
    );
  }
}
