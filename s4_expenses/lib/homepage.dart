import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
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

  String inputTitle = '';
  String inputAmount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CHART
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.blue,
                child: Text('CHART'),
                elevation: 5,
              ),
            ),
            // TEXT INPUT AREA
            Card(
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      onChanged: (value) => inputTitle = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Amount'),
                      onChanged: (value) => inputAmount = value,
                    ),
                    TextButton(
                      onPressed: () {
                        print(inputTitle);
                        print(inputAmount);
                      },
                      style: TextButton.styleFrom(primary: Colors.green),
                      child: const Text('Add Transaction'),
                    ),
                  ],
                ),
              ),
            ),
            // TRANSACTION LIST
            Column(
              children: transactions.map((tx) {
                return Card(
                    child: Row(children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 1)),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '\$${tx.amount}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tx.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy @ hh:mm:ss').format(tx.date),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ])
                ]));
              }).toList(),
            ),
          ]),
    );
  }
}
