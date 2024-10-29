// lib/presentation/bloc/coin_bloc/coin_event.dart

abstract class CoinEvent {}

class LoadCoinBalance extends CoinEvent {}

class UpdateCoinBalance extends CoinEvent {
  final int amount; // Positive or negative amount to update the balance

  UpdateCoinBalance(this.amount);
}