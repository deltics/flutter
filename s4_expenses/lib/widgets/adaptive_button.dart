import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  bool? isSolid = false;
  final String text;
  final Function onPressed;

  AdaptiveButton(
      {Key? key, this.isSolid, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSolid != null && isSolid!) {
      return Platform.isIOS
          ? CupertinoButton(
              child: Text(text),
              onPressed: () => onPressed(),
              color: Theme.of(context).primaryColor,
            )
          : TextButton(
              child: Text(text),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                primary: Colors.white,
              ),
              onPressed: () => onPressed(),
            );
    } else {
      return Platform.isIOS
          ? CupertinoButton(
              child: Text(text),
              onPressed: () => onPressed(),
            )
          : TextButton(
              child: Text(text),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              onPressed: () => onPressed(),
            );
    }
  }
}
