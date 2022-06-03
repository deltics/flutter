import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  String _message = "";
  // bool _isSending = true;
  bool _isSending = false;

  Future<void> _sendMessage({required BuildContext context}) async {
    print("sending...");
    FocusScope.of(context).unfocus();

    setState(() => _isSending = true);
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('chat').add({
        "from": uid,
        "text": _message,
        "createdAt": Timestamp.now(),
      });

      _message = "";
      _messageController.clear();
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  labelText: "new message",
                  labelStyle: TextStyle(
                    color: Colors.blueGrey.shade300,
                  )),
              controller: _messageController,
              onChanged: (value) {
                final trimmed = value.trim();
                if (_message != trimmed) {
                  setState(() => _message = trimmed);
                }
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.send),
            onPressed: _message.isEmpty
                ? null
                : () async => await _sendMessage(context: context),
          ),
        ],
      ),
    );
  }
}
