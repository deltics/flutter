import 'package:uuid/uuid.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
      required this.id,       
      required this.title,
      required this.amount,
      required this.date});

  static Transaction newTransaction({
    required String title,
    required double amount,
    required DateTime date}
  ) {
    return Transaction(id: const Uuid().v4(), title: title, amount: amount, date: date,);
  }
}
