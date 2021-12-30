import 'package:flutter/material.dart';

class HitButton extends StatelessWidget {
  late final VoidCallback _action;

  HitButton({Key? key, @required VoidCallback? action}) : super(key: key) {
    _action = action!;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _action,
      tooltip: 'Hit me!',
      child: const Icon(Icons.call_to_action),
    );
  }
}
