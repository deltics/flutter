// Imports
import 'package:flutter/material.dart';

// Dart entry point
void main() => runApp(const App());


// The App widget
class App extends StatelessWidget {
  const App({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Complete Guide'),
          ),
        body: Text('Default Text'),
      ),
    );
  }
}
