import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  late final List<Map<String, Object>> _questions;
  late final int _questionIndex;
  late final void Function(int) _answerHandler;

  Quiz(
      {Key? key,
      @required List<Map<String, Object>>? questions,
      @required int? questionIndex,
      @required void Function(int)? answerHandler})
      : super(key: key) {
    _questions = questions!;
    _questionIndex = questionIndex!;
    _answerHandler = answerHandler!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(text: _questions[_questionIndex]['text'].toString()),

        // Deep breath...
        //
        // We take the list of answers for the current question and map it
        //  to produce a list of Answer() widgets.  The spread operator ('...')
        //  that is applied to this result then places the resulting list of
        //  Answer() widgets in the list being passed to the 'children:' property
        //  (i.e. N Answer() widgets, rather than a single LIST of N Answer() widgets)

        ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
              text: answer['text'] as String,
              fn: () => _answerHandler(answer['score'] as int));
        }).toList(),
      ],
    );
  }
}
