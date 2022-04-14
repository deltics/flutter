import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFn;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.deleteFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: transactions.isEmpty
          ? Column(children: [
              const SizedBox(height: 10),
              const Text('no transactions recorded'),
              const SizedBox(height: 10),
              SizedBox(
                  height: 120,
                  child: Image.asset('assets/images/tumbleweed.png')),
            ])
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                var tx = transactions[index];
                return TransactionListItem(
                  key: ValueKey(tx.id),
                  transaction: tx,
                  deleteFn: deleteFn,
                );
              }),
    );
  }
}
