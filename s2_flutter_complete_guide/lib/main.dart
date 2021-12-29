// Imports
import 'package:flutter/material.dart';

// Dart entry point
void main() => runApp(const App());


// The App widget
class App extends StatelessWidget {
  const App({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Text('Hello!'),
    );
  }
}
