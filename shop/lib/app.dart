import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/product_catalog.dart';

import 'adapters/platform_app.dart';
import 'models/cart.dart';
import 'models/favorites.dart';
import 'models/orders.dart';
import 'models/products.dart';
import 'pages/cart.dart';
import 'pages/home.dart';
import 'pages/orders.dart';
import 'pages/product_detail.dart';
import 'pages/products.dart';

final routes = {
  HomePage.route: (ctx) => const HomePage(),
  CartPage.route: (ctx) => const CartPage(),
  ProductsPage.route: (ctx) => const ProductsPage(),
  ProductDetailPage.route: (ctx) => const ProductDetailPage(),
  OrdersPage.route: (ctx) => const OrdersPage(),
};

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Favorites()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: PlatformApp(
        title: 'Shop',
        primaryColor: Colors.purple,
        accentColor: Colors.orange,
        initialRoute: HomePage.route,
        routes: routes,
      ),
    );
  }
}
