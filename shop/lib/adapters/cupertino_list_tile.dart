import 'package:flutter/material.dart';

class CupertinoListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Function? onTap;

  const CupertinoListTile({
    Key? key,
    required this.leading,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        child: Row(children: [
          SizedBox(
            width: 50,
            child: leading,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: title),
        ]),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}
