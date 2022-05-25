import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static const route = "/splash";

  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("... loading ..."),
      ),
    );
  }
}
