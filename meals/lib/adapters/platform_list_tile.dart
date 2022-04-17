import 'dart:io';

import 'package:flutter/material.dart';

import 'cupertino_list_tile.dart';

class PlatformListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;

  const PlatformListTile({Key? key, required this.leading, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoListTile(
            leading: leading,
            title: title,
          )
        : ListTile(
            leading: leading,
            title: title,
          );
  }
}
