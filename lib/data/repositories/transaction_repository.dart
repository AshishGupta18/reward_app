// lib/data/repositories/transaction_repository.dart

import '/data/models/transaction_model.dart';
import '/domain/entities/transaction.dart';
import '/domain/repositories/transaction_repository_interface.dart';

class TransactionRepository implements TransactionRepositoryInterface {
  final List<TransactionModel> _transactions = [
    TransactionModel(transactionId: '1', rewardName: 'Discount Coupon', amount: 500, date: DateTime.now()),
    TransactionModel(transactionId: '2', rewardName: 'Gift Card', amount: 1000, date: DateTime.now()),
  ];

  @override
  List<Transaction> fetchTransactionHistory() {
    // Convert List<TransactionModel> to List<Transaction>
    return _transactions.map((transactionModel) => Transaction(
      id: transactionModel.transactionId,
      rewardName: transactionModel.rewardName,
      amount: transactionModel.amount,
      date: transactionModel.date,
    )).toList();
  }
}