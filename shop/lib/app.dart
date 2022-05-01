import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'adapters/platform_app.dart';
import 'app_theme.dart';
import 'models/cart.dart';
import 'models/favorites.dart';
import 'models/products.dart';
import 'pages/cart.dart';
import 'pages/home.dart';
import 'pages/product_detail.dart';

final routes = {
  HomePage.route: (ctx) => const HomePage(),
  CartPage.route: (ctx) => const CartPage(),
  ProductDetailPage.route: (ctx) => const ProductDetailPage(),
};

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
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: PlatformApp(
        title: 'Shop',
        primaryColor: theme.primaryColor,
        initialRoute: HomePage.route,
        routes: routes,
      ),
    );
  }
}
