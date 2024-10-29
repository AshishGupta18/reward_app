// lib/data/repositories/transaction_repository.dart

import '/data/models/transaction_model.dart';
import '/domain/entities/transaction.dart';
import '/domain/repositories/transaction_repository_interface.dart';

class TransactionRepository implements TransactionRepositoryInterface {
  final List<TransactionModel> _transactions = [
    TransactionModel( type: 'Discount Coupon', amount: 500, date: DateTime.now()),
    TransactionModel(type: 'Gift Card', amount: 1000, date: DateTime.now()),
  ];

  @override
  List<Transaction> fetchTransactionHistory() {
    // Convert List<TransactionModel> to List<Transaction>
    return _transactions.map((transactionModel) => Transaction(
      type: transactionModel.type,
      amount: transactionModel.amount,
      date: transactionModel.date,
    )).toList();
  }
}