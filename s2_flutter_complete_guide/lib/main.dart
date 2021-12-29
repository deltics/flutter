// Imports
import 'package:flutter/material.dart';

// Dart entry point
void main() => runApp(App());

// The App widget
class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  var questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    void answerQuestion() {
      print('Answered the question');
      setState(() {
        questionIndex++;
      });
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
            Text(questions[questionIndex]),
            ElevatedButton(
                child: const Text('Answer One'), onPressed: answerQuestion),
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
