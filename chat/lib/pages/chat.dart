import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatPage extends StatelessWidget {
  static const route = "/";

  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatterBox"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const Text("Rhubarb Rhubarb!"),
      ),
    );
  }
}
