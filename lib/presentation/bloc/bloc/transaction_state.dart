import '/domain/entities/transaction.dart';

abstract class TransactionState {}

class TransactionHistoryLoading extends TransactionState {}

class TransactionHistoryLoaded extends TransactionState {
  final List<Transaction> transactions;
  TransactionHistoryLoaded(this.transactions);
}

class TransactionHistoryError extends TransactionState {}