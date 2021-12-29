import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  late final String _text;
  late final VoidCallback _fn;

  Answer({Key? key, @required String? text, @required VoidCallback? fn})
      : super(key: key) {
    _text = text!;
    _fn = fn!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          onPrimary: Colors.white,
        ),
        child: Text(_text),
        onPressed: _fn,
      ),
    );
  }
}
