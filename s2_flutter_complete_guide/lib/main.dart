// Imports
import 'package:flutter/material.dart';
import "question.dart";
import 'answer.dart';

// Dart entry point
void main() => runApp(App());

// The App widget
class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _answerQuestion() {
      print('Answered the question');
      setState(() {
        _questionIndex++;
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
            Question(text: questions[_questionIndex]),
            Answer(text: 'Answered 1', fn: _answerQuestion),
            Answer(text: 'Answered 2', fn: _answerQuestion),
            Answer(text: 'Answered 3', fn: _answerQuestion),
          ],
        ),
      ),
    );
  }
}
