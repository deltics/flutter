import 'package:flutter/material.dart';
import 'package:s4_expenses/widgets/transaction_entry.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  // [
  //   Transaction(
  //     id: 't1',
  //     title: 'New Shoes',
  //     amount: 129.99,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Groceries',
  //     amount: 454.78,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't3',
  //     title: 'Petrol (CX-9)',
  //     amount: 152.36,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't4',
  //     title: 'Coffee',
  //     amount: 4.50,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't5',
  //     title: 'Petrol (Pretzel)',
  //     amount: 110.82,
  //     date: DateTime.now(),
  //   ),
  // ];

  void _showModalTransactionEntry(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TransactionEntry(addFunction: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showModalTransactionEntry(context),
        )
      ]),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CHART
            const SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART'),
                elevation: 5,
              ),
            ),
            TransactionList(
              transactions: _transactions,
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showModalTransactionEntry(context),
      ),
    );
  }

  void _addTransaction(String title, double amount) {
    final tx = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: 't${_transactions.length.toString()}',
    );

    setState(() {
      _transactions.add(tx);
    });
  }
}
