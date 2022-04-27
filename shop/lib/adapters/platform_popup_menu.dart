import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformMenuItem<T> {
  final Widget child;
  final T value;

  PlatformMenuItem({
    required this.child,
    required this.value,
  });
}

class PlatformPopupMenu extends StatelessWidget {
  final Icon icon;
  final List<PlatformMenuItem> items;
  final Function onSelected;

  const PlatformPopupMenu({
    Key? key,
    required this.icon,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? GestureDetector(
            child: icon,
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Column(
                    children: items
                        .map((item) => GestureDetector(
                              onTap: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(item.value),
                              child: item.child,
                            ))
                        .toList(),
                  ),
                );
              },
            ).then(
              (value) => onSelected(value),
            ),
          )
        : PopupMenuButton(
            onSelected: (value) => onSelected(value),
            itemBuilder: (_) => items
                .map(
                  (item) => PopupMenuItem(
                    child: item.child,
                    value: item.value,
                  ),
                )
                .toList(),
          );
  }
}
