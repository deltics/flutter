import 'package:chat/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_messages.dart';

class ChatPage extends StatefulWidget {
  static const route = "/";

  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void _initNotifications() async {
    final notifications = FirebaseMessaging.instance;
    final settings = await notifications.requestPermission();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }

    FirebaseMessaging.onMessage.listen((msg) {
      if (kDebugMode) {
        if (msg.notification != null) {
          print("onMessage.notification.title: ${msg.notification!.title}");
          print("onMessage.notification.body: ${msg.notification!.body}");
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      if (kDebugMode) {
        print("onMessageOpenedApp: $msg");
      }
    });

    try {
      await FirebaseMessaging.instance.subscribeToTopic('chat');
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _initNotifications();
  }

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
    );
  }
}
