import 'package:flutter_bloc/flutter_bloc.dart';
import 'coin_event.dart';
import 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  CoinBloc() : super(CoinLoading()) {
    // Initialize with default coin balance
    on<LoadCoinBalance>((event, emit) {
      // Mock initial balance of 1000 coins
      emit(CoinLoaded(balance: 1000));
    });
  }

  // Method to reload or update balance if needed
  void loadBalance() => add(LoadCoinBalance());
}