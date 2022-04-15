import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meals/widgets/cupertino_ink_well.dart';

class PlatformInkWell extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final Function onPressed;

  const PlatformInkWell({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoInkWell(
            onPressed: () => onPressed(),
            child: child,
          )
        : InkWell(
            onTap: () => onPressed(),
            splashColor: Theme.of(context).primaryColor,
            borderRadius: borderRadius,
            child: child,
          );
  }
}
