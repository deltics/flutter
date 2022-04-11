import 'package:flutter/material.dart';

class TransactionEntry extends StatelessWidget {
  final Function addFunction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  TransactionEntry({Key? key, required this.addFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
              onPressed: () {
                addFunction(
                    titleController.text, double.parse(amountController.text));
              },
              style: TextButton.styleFrom(primary: Colors.green),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
