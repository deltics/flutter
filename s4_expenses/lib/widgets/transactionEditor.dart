import 'package:flutter/material.dart';

import '../../models/transaction.dart';

import 'transactionEntry.dart';
import 'transactionList.dart';

class TransactionEditor extends StatefulWidget {
  const TransactionEditor({Key? key}) : super(key: key);

  @override
  State<TransactionEditor> createState() => _TransactionEditorState();
}

class _TransactionEditorState extends State<TransactionEditor> {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 129.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Groceries',
      amount: 454.78,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TEXT INPUT AREA
        TransactionEntry(addFunction: _addTransaction),
        // TRANSACTION LIST
        TransactionList(transactions: transactions),
      ],
    );
  }

  void _addTransaction(String title, double amount) {
    final tx = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: transactions.length.toString(),
    );

    setState(() {
      transactions.add(tx);
    });
  }
}
