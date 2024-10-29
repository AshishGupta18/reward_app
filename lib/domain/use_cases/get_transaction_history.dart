// lib/domain/use_cases/get_transaction_history.dart

import '/domain/repositories/transaction_repository_interface.dart';
import '/domain/entities/transaction.dart';

class GetTransactionHistory {
  final TransactionRepositoryInterface repository;

  GetTransactionHistory(this.repository);

  List<Transaction> call() {
    return repository.fetchTransactionHistory();
  }
}