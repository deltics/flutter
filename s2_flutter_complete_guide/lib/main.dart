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
      'answers': [
        {'text': 'Black', 'score': 0},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 7},
        {'text': 'Blue', 'score': 10}
      ],
    },
    {
      'text': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 8},
        {'text': 'Snake', 'score': 0},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 10},
        {'text': 'Gekko', 'score': 6}
      ],
    },
    {
      'text': 'What\'s your favorite language?',
      'answers': [
        {'text': 'Pascal', 'score': 10},
        {'text': 'Go', 'score': 9},
        {'text': 'Dart', 'score': 8},
        {'text': 'C#', 'score': 8},
        {'text': 'COBOL', 'score': 2},
        {'text': 'JavaScript', 'score': 0}
      ],
    },
  ];

  var _questionIndex = 0;
  var _score = 0;

  void _answerQuestion(int score) {
    _score += score;

    setState(() {
      _questionIndex++;
    });
  }

  void _restart() {
    _score = 0;

    setState(() {
      _questionIndex = 0;
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
            : Result(score: _score, restart: _restart),
      ),
    );
  }
}
