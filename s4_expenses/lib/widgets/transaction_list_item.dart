import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    required Key key,
    required this.transaction,
    required this.deleteFn,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteFn;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 3,
      ),
      child: ListTile(
        leading: CircleAvatar(
            child: Padding(
          padding: const EdgeInsets.all(3),
          child: FittedBox(child: Text(transaction.amount.toStringAsFixed(2))),
        )),
        title: Text(
          transaction.title,
          style: const TextStyle(
            fontFamily: 'Chalkduster',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          DateFormat('dd MMM yyyy @ hh:mm:ss').format(transaction.date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteFn(id: transaction.id),
        ),
      ),
    );
  }
}
