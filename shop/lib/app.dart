import 'package:flutter/material.dart';

import 'adapters/platform_app.dart';
import 'pages/home.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(title: 'Shop', routes: {
      HomePage.route: (ctx) => HomePage(
            title: 'Shop',
          ),
    });
  }
}
