import 'package:chat/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_messages.dart';

class ChatPage extends StatelessWidget {
  static const route = "/";

  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatterBox"),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    "ChatterBox",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () => FirebaseAuth.instance.signOut(),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: const [
            Expanded(
              child: ChatMessages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () => FirebaseFirestore.instance
      //       .collection("chats/_collection/messages")
      //       .add({"text": "Added by the app!"}),
      // ),
    );
  }
}
