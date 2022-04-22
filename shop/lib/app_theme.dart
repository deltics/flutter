import 'package:flutter/material.dart';

class AppTheme {
  final Color gridIconColor;
  final Color pageTitleColor;
  final Color primaryColor;

  const AppTheme({
    this.gridIconColor = Colors.white,
    this.primaryColor = Colors.blue,
    this.pageTitleColor = Colors.white,
  });
}

var theme = const AppTheme();
