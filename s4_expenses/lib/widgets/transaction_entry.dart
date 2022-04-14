import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s4_expenses/widgets/adaptive_field.dart';

import 'adaptive_button.dart';

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
    DateTime chosenDate = DateTime.now();

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
                            initialDateTime: chosenDate,
                            maximumDate: DateTime.now(),
                            minimumDate: DateTime(chosenDate.year - 1),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (val) {
                              setState(() {
                                chosenDate = val;
                              });
                            }),
                      ),

                      // Close the modal
                      CupertinoButton(
                        child: const Text('OK'),
                        onPressed: () {
                          setState(() {
                            _transactionDate = chosenDate;
                          });

                          Navigator.of(ctx).pop();
                        },
                      )
                    ],
                  ),
                ))
        : showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
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
            AdaptiveTextField(
              hint: 'Title',
              controller: _titleController,
              onSubmitted: () => _submit(),
            ),
            AdaptiveTextField(
              hint: 'Amount',
              controller: _amountController,
              onSubmitted: () => _submit(),
            ),
            Row(children: [
              Expanded(
                child: Text(_transactionDate == null
                    ? 'No date selected'
                    : DateFormat('dd MMM yyyy @ hh:mm')
                        .format(_transactionDate!)),
              ),
              AdaptiveButton(
                  text:
                      _transactionDate == null ? 'Choose date' : 'Change date',
                  onPressed: () => _showDatePicker(context)),
            ]),
            AdaptiveButton(
              text: 'Add Transaction',
              isSolid: true,
              onPressed: () => _submit(),
            )
          ],
        ),
      ),
    );
  }
}
