import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformPage extends StatelessWidget {
  final Widget content;
  final String title;

  const PlatformPage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(title),
            ),
            child: SafeArea(child: content),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: SafeArea(child: content),
          );
  }
}
