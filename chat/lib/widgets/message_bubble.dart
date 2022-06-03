import 'package:flutter/material.dart';

import '../data/models/user_profile.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final Future<UserProfile>? sender;

  const MessageBubble({
    Key? key,
    required this.message,
    this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rounded = Radius.circular(18);
    const square = Radius.circular(0);

    final bool wasReceived = sender != null;

    return Row(
      mainAxisAlignment:
          wasReceived ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: wasReceived
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.only(
              topLeft: rounded,
              topRight: rounded,
              bottomRight: wasReceived ? square : rounded,
              bottomLeft: wasReceived ? rounded : square,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: wasReceived
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        if (wasReceived)
          FutureBuilder(
            future: sender,
            builder: (context, snapshot) => !snapshot.hasData
                ? SizedBox.square(
                    dimension: 12,
                    child: CircularProgressIndicator(
                      color: Colors.blueGrey.shade400,
                    ))
                : Column(
                    children: [
                      const SizedBox(height: 4),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blueGrey.shade600,
                        backgroundImage:
                            (snapshot.data as UserProfile).picture?.image,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (snapshot.data as UserProfile).username,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blueGrey.shade400,
                        ),
                      ),
                    ],
                  ),
          ),
      ],
    );
  }
}
