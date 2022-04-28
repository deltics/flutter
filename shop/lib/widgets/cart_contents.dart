import 'package:flutter/material.dart';

import '../models/cart.dart';

class CartContents extends StatelessWidget {
  const CartContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Cart.of(context: context);

    return Column(
      children: [
        Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Text('Total'),
                  const SizedBox(width: 10),
                  Chip(
                    label: Text('${cart.totalAmount}'),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
