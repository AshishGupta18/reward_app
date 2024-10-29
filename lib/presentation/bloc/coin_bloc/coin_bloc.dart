// lib/presentation/bloc/coin_bloc/coin_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/transaction.dart';
import 'coin_event.dart';
import 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  int balance = 1000; // Default starting balance
  List<Transaction> transactionHistory = []; // List to hold transactions

  CoinBloc() : super(CoinInitial()) {
    on<LoadCoinBalance>((event, emit) {
      emit(CoinLoaded(balance)); // Emit initial balance
    });

    on<UpdateCoinBalance>((event, emit) {
      balance += event.amount; // Update balance with the provided amount

      // Log transaction
      String type = event.amount > 0 ? 'Scratch Card Reward' : 'Redeemed Item';
      transactionHistory.add(Transaction(date: DateTime.now(), type: type, amount: event.amount.abs()));

      emit(CoinLoaded(balance)); // Emit the new balance state
    });
  }
}