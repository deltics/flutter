import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionEntry extends StatefulWidget {
  final Function addFunction;

  const TransactionEntry({Key? key, required this.addFunction})
      : super(key: key);

  @override
  State<TransactionEntry> createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _transactionDate;

  void submit() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

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
              controller: _titleController,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submit(),
            ),
            Row(children: [
              Expanded(
                child: Text(_transactionDate == null
                    ? 'No date selected'
                    : DateFormat('dd MMM yyyy @ hh:mm')
                        .format(_transactionDate!)),
              ),
              TextButton(
                child: Text(_transactionDate == null
                    ? 'Choose date/time'
                    : 'Change date/time'),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime.now(),
                  ).then((dt) {
                    if (dt == null) {
                      return;
                    }

                    setState(() {
                      _transactionDate = dt;
                    });
                  });
                },
              ),
            ]),
            TextButton(
              onPressed: () => submit(),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                primary: Colors.white,
              ),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
