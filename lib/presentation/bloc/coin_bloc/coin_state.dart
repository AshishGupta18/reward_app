abstract class CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final int balance;

  CoinLoaded({required this.balance});
}