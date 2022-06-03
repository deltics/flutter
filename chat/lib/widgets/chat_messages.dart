import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/providers/users.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final users = Users.of(context);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = (snapshot.data as QuerySnapshot).docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final fromUid = doc["from"];

            if (fromUid == uid) {
              return MessageBubble(
                key: ValueKey(doc.id),
                message: doc["text"],
              );
            }

            return MessageBubble(
              key: ValueKey(doc.id),
              message: doc["text"],
              senderName: users.getName(uid: fromUid),
            );
          },
          reverse: true,
        );
      },
    );
  }
}
