import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final Future<String>? senderName;

  const MessageBubble({
    Key? key,
    required this.message,
    this.senderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rounded = Radius.circular(18);
    const square = Radius.circular(0);

    final bool wasReceived = senderName != null;

    return Row(
      mainAxisAlignment:
          wasReceived ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (wasReceived)
          FutureBuilder(
            future: senderName,
            builder: (context, snapshot) => !snapshot.hasData
                ? SizedBox.square(
                    dimension: 12,
                    child: CircularProgressIndicator(
                      color: Colors.blueGrey.shade400,
                    ))
                : Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      snapshot.data! as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey.shade400,
                      ),
                    ),
                  ),
          ),
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
      ],
    );
  }
}
