import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;

  const ChartBar(
      {Key? key,
      required this.label,
      required this.amount,
      required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final total = amount > 0.0 ? amount.ceil().toStringAsFixed(0) : "-";

      return Column(children: [
        SizedBox(
          height: constraints.maxHeight * 0.15,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: FittedBox(child: Text(total)),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.05),
        SizedBox(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 200, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                      decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ))),
            ],
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.05),
        SizedBox(
          height: constraints.maxHeight * 0.15,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: FittedBox(child: Text(label)),
          ),
        ),
      ]);
    });
  }
}
