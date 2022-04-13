import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoApp(
            title: 'My Money',
            home: HomePage(title: 'My Money'),
          )
        : MaterialApp(
            title: 'My Money',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomePage(title: 'MyMoney'),
          );
  }
}
