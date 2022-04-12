import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart({Key? key, required this.transactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionTotals {
    return List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: index));
      final weekdayLabelText = DateFormat.E().format(date).substring(0, 1);

      double weekdayTotalAmount = 0;

      for (var tx in transactions) {
        if (tx.date.day == date.day &&
            tx.date.month == date.month &&
            tx.date.year == date.year) {
          weekdayTotalAmount += tx.amount;
        }
      }

      return {'day': weekdayLabelText, 'total': weekdayTotalAmount};
    }).reversed.toList();
  }

  double get totalSpend {
    return groupedTransactionTotals.fold(0.0, (sum, item) {
      return sum + (item['total'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(20),
            child: Row(
                children: groupedTransactionTotals.map((day) {
              final label = '${day['day']}';
              final amount = (day['total'] as double);
              final pct = totalSpend > 0 ? amount / totalSpend : 0.0;

              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(label: label, amount: amount, percentage: pct),
              );
            }).toList())));
  }
}
