import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  late final String _text;

  Question({@required String? text, Key? key}) : super(key: key) {
    _text = text!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      child: Text(_text,
          style: const TextStyle(fontSize: 28, fontFamily: 'Arial'),
          textAlign: TextAlign.center),
    );
  }
}
