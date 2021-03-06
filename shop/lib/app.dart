import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'adapters/platform_app.dart';
import 'models/auth.dart';
import 'models/cart.dart';
import 'models/favorites.dart';
import 'models/orders.dart';
import 'models/products.dart';
import 'pages/auth.dart';
import 'pages/cart.dart';
import 'pages/edit_product.dart';
import 'pages/home.dart';
import 'pages/orders.dart';
import 'pages/product_detail.dart';
import 'pages/products.dart';
import 'pages/splash.dart';

final routes = {
  CartPage.route: (ctx) => const CartPage(),
  EditProductPage.route: (ctx) => const EditProductPage(),
  ProductsPage.route: (ctx) => const ProductsPage(),
  ProductDetailPage.route: (ctx) => const ProductDetailPage(),
  OrdersPage.route: (ctx) => const OrdersPage(),
  AuthPage.route: (ctx) => const AuthPage(),
};

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProxyProvider<Auth, Favorites?>(
          create: (_) => null,
          update: (context, auth, _) =>
              auth.isSignedIn ? Favorites(userId: auth.userId) : null,
        ),
        ChangeNotifierProxyProvider<Auth, Orders?>(
          create: (_) => null,
          update: (context, auth, _) =>
              auth.isSignedIn ? Orders(userId: auth.userId) : null,
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return PlatformApp(
            title: 'Shop',
            primaryColor: Colors.purple,
            accentColor: Colors.orange,
            home: auth.isSignedIn
                ? const HomePage()
                : FutureBuilder(
                    future: auth.tryAutoSignIn(),
                    builder: (_, result) =>
                        result.connectionState == ConnectionState.waiting
                            ? const Splash()
                            : const AuthPage(),
                  ),
            routes: routes,
          );
        },
      ),
    );
  }
}
