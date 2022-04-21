import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformApp extends StatelessWidget {
  final String title;
  final String initialRoute;
  final Color primaryColor;
  final Map<String, Widget Function(BuildContext)> routes;

  const PlatformApp({
    Key? key,
    this.initialRoute = '/',
    this.primaryColor = Colors.blue,
    required this.routes,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: title,
            theme: CupertinoThemeData(
              primaryColor: primaryColor,
            ),
            initialRoute: initialRoute,
            routes: routes,
          )
        : MaterialApp(
            title: title,
            theme: ThemeData(
                colorSchemeSeed: primaryColor,
                fontFamily: 'Raleway',
                textTheme: ThemeData.light().textTheme.copyWith(
                      bodyText1: const TextStyle(
                        color: Color.fromRGBO(20, 51, 51, 1),
                      ),
                      bodyText2: const TextStyle(
                        color: Color.fromRGBO(20, 51, 51, 1),
                      ),
                      headline6: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
            initialRoute: initialRoute,
            routes: routes,
          );
  }
}
