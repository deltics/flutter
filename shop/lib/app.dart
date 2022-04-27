import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'adapters/platform_app.dart';
import 'app_theme.dart';
import 'models/favorites.dart';
import 'pages/home.dart';
import 'pages/product_detail.dart';
import 'pages/products.dart';
import 'models/products.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Favorites()),
      ],
      child: PlatformApp(
        title: 'Shop',
        primaryColor: theme.primaryColor,
        initialRoute: HomePage.route,
        routes: {
          HomePage.route: (ctx) => const HomePage(title: 'Shop'),
          ProductsPage.route: (ctx) => const ProductsPage(),
          ProductDetailPage.route: (ctx) => const ProductDetailPage(),
        },
      ),
    );
  }
}
