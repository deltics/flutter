import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'adapters/platform_app.dart';
import 'app_theme.dart';
import 'pages/home.dart';
import 'pages/product_detail.dart';
import 'pages/products.dart';
import 'providers/products_provider.dart';

class ShopApp extends StatelessWidget {
  final ProductsProvider _products = ProductsProvider();

  ShopApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    theme = const AppTheme(
      primaryColor: Colors.purple,
      gridIconColor: Colors.orange,
      pageTitleColor: Colors.white,
    );

    return ChangeNotifierProvider(
      create: (ctx) => ProductsProvider(),
      child: PlatformApp(
        title: 'Shop',
        primaryColor: theme.primaryColor,
        initialRoute: ProductsPage.route,
        routes: {
          HomePage.route: (ctx) => const HomePage(title: 'Shop'),
          ProductsPage.route: (ctx) => const ProductsPage(),
          ProductDetailPage.route: (ctx) => const ProductDetailPage(),
        },
      ),
    );
  }
}
