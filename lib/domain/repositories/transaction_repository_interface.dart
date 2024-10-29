// lib/domain/repositories/transaction_repository_interface.dart

import '/domain/entities/transaction.dart';

abstract class TransactionRepositoryInterface {
  List<Transaction> fetchTransactionHistory();
}