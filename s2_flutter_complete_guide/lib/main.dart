// Imports
import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';

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
  static const _questions = [
    {
      'text': 'What\'s your favorite color?',
      'answers': ['Black', 'Red', 'Green', 'Blue'],
    },
    {
      'text': 'What\'s your favorite animal?',
      'answers': ['Rabbit', 'Snake', 'Elephant', 'Lion', 'Gekko'],
    },
    {
      'text': 'What\'s your favorite language?',
      'answers': ['Pascal', 'Go', 'Dart', 'C#', 'COBOL', 'JavaScript'],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion() {
    print('Answered the question');
    setState(() {
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Complete Guide'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                answerHandler: _answerQuestion)
            : const Result(),
      ),
    );
  }
}
