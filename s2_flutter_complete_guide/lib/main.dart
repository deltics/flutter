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

  Widget currentActivity() {
    return _questionIndex < _questions.length
        ? Column(
            children: [
              Question(text: _questions[_questionIndex]['text'].toString()),

              // Deep breath...
              //
              // We take the list of answers for the current question and map it
              //  to produce a list of Answer() widgets.  The spread operator ('...')
              //  that is applied to this result then places the resulting list of
              //  Answer() widgets in the list being passed to the 'children:' property
              //  (i.e. N Answer() widgets, rather than a single LIST of N Answer() widgets)

              ...(_questions[_questionIndex]['answers'] as List<String>)
                  .map((answer) {
                return Answer(text: answer, fn: _answerQuestion);
              }).toList(),
            ],
          )
        : const Center(child: Text('All Done!'));
  }

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
          body: currentActivity()),
    );
  }
}
