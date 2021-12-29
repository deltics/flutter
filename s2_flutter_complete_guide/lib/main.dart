// Imports
import 'package:flutter/material.dart';

// Dart entry point
void main() => runApp(const App());


// The App widget
class App extends StatelessWidget {
  const App({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var questions = [
      'What\'s your favorite color?',
      'What\'s your favorite animal?',
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Complete Guide'),
        ),
        body: Column(
          children: [
            Text('The question?'),
            ElevatedButton(
              child: Text('Answer One'),
              onPressed: null
            ),
            ElevatedButton(
              child: Text('Answer Two'),
              onPressed: null
            ),
            ElevatedButton(
              child: Text('Answer Three'),
              onPressed: null
            ),
          ],
        ),
      ),
    );
  }
}
