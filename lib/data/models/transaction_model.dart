// lib/models/transaction.dart

class TransactionModel {
  final DateTime date;
  final String type;
  final int amount;

  TransactionModel({required this.date, required this.type, required this.amount});
}