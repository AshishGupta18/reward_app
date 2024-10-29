// lib/presentation/bloc/coin_bloc/coin_state.dart

abstract class CoinState {}

class CoinInitial extends CoinState {} // Initial state

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final int balance;

  CoinLoaded(this.balance);
}

class CoinError extends CoinState {
  final String message;

  CoinError(this.message);
}