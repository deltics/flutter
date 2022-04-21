import 'dart:io';

import 'package:flutter/material.dart';

import 'cupertino_list_tile.dart';

class PlatformListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  Function? onTap;

  PlatformListTile({
    Key? key,
    required this.leading,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoListTile(
            leading: leading,
            title: title,
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
          )
        : ListTile(
            leading: leading,
            title: title,
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
          );
  }
}
