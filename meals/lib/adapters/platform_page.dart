import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageAction {
  final Icon icon;
  final Function onPressed;

  const PageAction({
    required this.icon,
    required this.onPressed,
  });
}

class PlatformPage extends StatelessWidget {
  final Widget content;
  final String title;
  PageAction? action;

  PlatformPage({
    Key? key,
    required this.title,
    required this.content,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(title),
              trailing: (action != null)
                  ? GestureDetector(
                      child: action!.icon,
                      onTap: () => action!.onPressed(context),
                    )
                  : null,
            ),
            child: SafeArea(child: content),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: SafeArea(child: content),
            floatingActionButton: (action != null)
                ? FloatingActionButton(
                    child: action!.icon,
                    onPressed: () => action!.onPressed(context),
                  )
                : null,
          );
  }
}
