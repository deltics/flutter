import 'dart:io';

import 'package:flutter/cupertino.dart';
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

  void _submit() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        _transactionDate == null) {
      return;
    }

    widget.addFunction(title, amount, _transactionDate!);

    Navigator.of(context).pop();
  }

  void _showDatePicker(BuildContext ctx) {
    DateTime? chosenDate;
    setState(() {
      _transactionDate = DateTime.now();
    });

    Platform.isIOS
        ? showCupertinoModalPopup(
            context: ctx,
            builder: (_) => Container(
                  height: 500,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 400,
                        child: CupertinoDatePicker(
                            initialDateTime: _transactionDate,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (val) {
                              setState(() {
                                _transactionDate = val;
                              });
                            }),
                      ),

                      // Close the modal
                      CupertinoButton(
                        child: const Text('OK'),
                        onPressed: () => {Navigator.of(ctx).pop()},
                      )
                    ],
                  ),
                ))
        : showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now(),
          ).then((val) {
            if (val == null) {
              return;
            }

            setState(() {
              _transactionDate = val;
            });
          });
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
          children: [
            Platform.isIOS
                ? CupertinoTextField(
                    placeholder: 'Title',
                    enabled: true,
                    controller: _titleController,
                    onSubmitted: (_) => _submit(),
                  )
                : TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    onSubmitted: (_) => _submit(),
                  ),
            Platform.isIOS
                ? CupertinoTextField(
                    placeholder: 'Amount',
                    enabled: true,
                    controller: _amountController,
                    onSubmitted: (_) => _submit(),
                  )
                : TextField(
                    decoration: const InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _submit(),
                  ),
            Row(children: [
              Expanded(
                child: Text(_transactionDate == null
                    ? 'No date selected'
                    : DateFormat('dd MMM yyyy @ hh:mm')
                        .format(_transactionDate!)),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: Text(_transactionDate == null
                          ? 'Choose date/time'
                          : 'Change date/time'),
                      onPressed: () => _showDatePicker(context),
                    )
                  : TextButton(
                      child: Text(_transactionDate == null
                          ? 'Choose date/time'
                          : 'Change date/time'),
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      onPressed: () => _showDatePicker(context),
                    ),
            ]),
            Platform.isIOS
                ? CupertinoButton(
                    child: const Text('Add Transaction'),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _submit(),
                  )
                : TextButton(
                    onPressed: () => _submit(),
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
