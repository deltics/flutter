import 'package:flutter/material.dart';
import 'package:s4_expenses/widgets/transaction_entry.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction.newTransaction(
      title: 'New Shoes',
      amount: 129.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction.newTransaction(
      title: 'Groceries',
      amount: 454.78,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction.newTransaction(
      title: 'Petrol (CX-9)',
      amount: 152.36,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction.newTransaction(
      title: 'Coffee',
      amount: 4.50,
      date: DateTime.now(),
    ),
    Transaction.newTransaction(
      title: 'Petrol (Pretzel)',
      amount: 110.82,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
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
            Chart(
              transactions: _recentTransactions,
            ),
            TransactionList(
                transactions: _transactions, deleteFn: _deleteTransaction),
          ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showModalTransactionEntry(context),
      ),
    );
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final tx = Transaction.newTransaction(
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _transactions.add(tx);
    });
  }

  void _deleteTransaction({required String id}) {
    setState(() => _transactions.removeWhere((tx) => tx.id == id));
  }

  void _showModalTransactionEntry(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TransactionEntry(addFunction: _addTransaction);
        });
  }
}
