// lib/data/repositories/coin_repository.dart

import '/domain/repositories/coin_repository_interface.dart';

class CoinRepository implements CoinRepositoryInterface {
  int _coinBalance = 1000;

  @override
  int fetchCoinBalance() => _coinBalance;
}