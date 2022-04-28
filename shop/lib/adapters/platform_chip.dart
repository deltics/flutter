import 'package:flutter/material.dart';

class PlatformChip extends StatelessWidget {
  final Widget label;

  const PlatformChip({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green.shade200,
      ),
      child: Row(
        children: [
          label,
        ],
      ),
    );
  }
}
