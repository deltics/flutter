// Imports
import 'package:flutter/material.dart';

// Dart entry point
void main() => runApp(const App());

// The App widget
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void answerOne() {
      print('Answered \'One\'');
    }

    var questions = [
      'What\'s your favorite color?',
      'What\'s your favorite animal?',
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Complete Guide'),
        ),
        body: Column(
          children: [
            const Text('The question?'),
            ElevatedButton(
                child: const Text('Answer One'), onPressed: answerOne),
            ElevatedButton(
                child: const Text('Answer Two'),
                onPressed: () => print('Answered \'Two\'')),
            ElevatedButton(
                child: const Text('Answer Three'),
                onPressed: () {
                  print('Answered \'Three\'');
                }),
          ],
        ),
      ),
    );
  }
}
