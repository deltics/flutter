import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  late final int _score;
  late final VoidCallback _restart;

  String get resultPhrase {
    return 'Well done!\nYou scored ' +
        _score.toString() +
        '/30\n\nThat\'s ' +
        (_score * 100 / 30).toString() +
        '%';
  }

  Result({Key? key, @required int? score, @required VoidCallback? restart})
      : super(key: key) {
    _score = score!;
    _restart = restart!;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(onPressed: _restart, child: const Text('Try Again'))
        ],
      ),
    );
  }
}
