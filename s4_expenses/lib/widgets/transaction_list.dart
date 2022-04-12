import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

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
                final tx = transactions[index];

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
                      child:
                          FittedBox(child: Text(tx.amount.toStringAsFixed(2))),
                    )),
                    title: Text(
                      tx.title,
                      style: const TextStyle(
                        fontFamily: 'Chalkduster',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('dd MMM yyyy @ hh:mm:ss').format(tx.date),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
