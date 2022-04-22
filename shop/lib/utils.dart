import 'package:flutter/material.dart';

Map<String, String> routeArguments(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as Map<String, String>;
}
