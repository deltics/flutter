import 'dart:math';

import 'package:flutter/material.dart';

import 'hitButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = 'Hit the button!';

  void _changeText() {
    setState(() {
      var random = Random();
      var option = random.nextInt(3);

      switch (option) {
        case 0:
          _text = 'Ouch!';
          break;

        case 1:
          _text = 'OW!';
          break;

        case 2:
          _text = 'OOOF!';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assignment'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_text),
            ],
          ),
        ),
        floatingActionButton: HitButton(action: _changeText));
  }
}
