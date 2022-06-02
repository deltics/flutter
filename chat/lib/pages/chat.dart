import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        itemBuilder: (context, index) => const Text("Rhubarb! Rhubarb!"),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final messages = FirebaseFirestore.instance
                .collection('chats/_collection/messages');
            final stream = messages.snapshots();

            stream.listen((event) {
              if (kDebugMode) {
                print(event);
              }
            });
          }),
    );
  }
}
