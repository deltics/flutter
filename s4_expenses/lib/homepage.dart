import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/transactionEditor.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
            const TransactionEditor(),
          ]),
    );
  }
}
