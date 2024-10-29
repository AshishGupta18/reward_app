// lib/domain/use_cases/get_coin_balance.dart

import '/domain/repositories/coin_repository_interface.dart';

class GetCoinBalance {
  final CoinRepositoryInterface repository;

  GetCoinBalance(this.repository);

  int call() {
    return repository.fetchCoinBalance();
  }
}