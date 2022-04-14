import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function onSubmitted;

  const AdaptiveTextField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            placeholder: hint,
            enabled: true,
            controller: controller,
            onSubmitted: (_) => onSubmitted(),
          )
        : TextField(
            decoration: InputDecoration(labelText: hint),
            controller: controller,
            onSubmitted: (_) => onSubmitted(),
          );
  }
}
