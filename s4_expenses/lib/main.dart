import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  // How to limit orientations, if you wish:
  // (requires import flutter/services.dart)

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(const App());
}
