import 'package:flutter/material.dart';

class TransactionEntry extends StatefulWidget {
  final Function addFunction;

  const TransactionEntry({Key? key, required this.addFunction})
      : super(key: key);

  @override
  State<TransactionEntry> createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submit() {
    final title = titleController.text;
    final amount = double.tryParse(amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) {
      return;
    }

    widget.addFunction(title, amount);

    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submit(),
            ),
            TextButton(
              onPressed: () => submit(),
              style: TextButton.styleFrom(primary: Colors.green),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
