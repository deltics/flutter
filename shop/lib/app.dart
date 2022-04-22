import 'package:flutter/material.dart';
import 'package:shop/pages/products.dart';

import 'adapters/platform_app.dart';
import 'app_theme.dart';
import 'pages/home.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    theme = const AppTheme(
      primaryColor: Colors.purple,
      gridIconColor: Colors.orange,
      pageTitleColor: Colors.white,
    );

    return PlatformApp(
      title: 'Shop',
      primaryColor: theme.primaryColor,
      routes: {
        //HomePage.route: (ctx) => const HomePage(title: 'Shop'),
        HomePage.route: (ctx) => const ProductsPage(),
      },
    );
  }
}
