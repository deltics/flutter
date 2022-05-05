import 'package:flutter/material.dart';

class PlatformApp extends StatelessWidget {
  final String title;
  final String initialRoute;
  final MaterialColor primaryColor;
  final Color accentColor;
  final Map<String, Widget Function(BuildContext)> routes;

  const PlatformApp({
    Key? key,
    this.initialRoute = '/',
    this.primaryColor = Colors.purple,
    this.accentColor = Colors.orange,
    required this.routes,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: primaryColor,
            accentColor: accentColor,
          ),
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
