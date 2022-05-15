import 'package:flutter/material.dart';

class PageAction {
  final Widget child;
  final Function onPressed;

  const PageAction({
    required this.child,
    required this.onPressed,
  });
}

class PlatformPage extends StatelessWidget {
  final Widget content;
  final String title;
  final List<Widget>? actions;
  final PageAction? floatingAction;
  final Widget? drawer;

  const PlatformPage({
    Key? key,
    required this.title,
    required this.content,
    this.floatingAction,
    this.actions,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: drawer,
    );
  }
}
