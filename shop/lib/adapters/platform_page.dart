import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class PageAction {
  final Widget child;
  final Function onPressed;

  const PageAction({
    required this.child,
    required this.onPressed,
  });
}

class PlatformPage extends StatelessWidget {
  final AppTheme theme;
  final Widget content;
  final String title;
  final List<Widget>? actions;
  final PageAction? floatingAction;

  const PlatformPage({
    Key? key,
    required this.theme,
    required this.title,
    required this.content,
    this.floatingAction,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: theme.primaryColor,
              leading: GestureDetector(
                child: Icon(
                  Icons.chevron_left,
                  color: theme.pageTitleColor,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              middle: Text(title,
                  style: TextStyle(
                    color: theme.pageTitleColor,
                  )),
              trailing: (floatingAction != null)
                  ? GestureDetector(
                      child: floatingAction!.child,
                      onTap: () => floatingAction!.onPressed(context),
                    )
                  : null,
            ),
            child: SafeArea(child: content),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: actions,
            ),
            body: SafeArea(child: content),
            floatingActionButton: (floatingAction != null)
                ? FloatingActionButton(
                    child: floatingAction!.child,
                    onPressed: () => floatingAction!.onPressed(context),
                  )
                : null,
          );
  }
}
