import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/entities/transaction.dart';
import '/domain/use_cases/get_transaction_history.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionHistory getTransactionHistory;

  TransactionBloc(this.getTransactionHistory) : super(TransactionHistoryLoading()) {
    on<LoadTransactionHistory>(_onLoadTransactionHistory);
  }

  void _onLoadTransactionHistory(
      LoadTransactionHistory event, Emitter<TransactionState> emit) async {
    emit(TransactionHistoryLoading());
    try {
      final transactions = await getTransactionHistory();
      emit(TransactionHistoryLoaded(transactions));
    } catch (_) {
      emit(TransactionHistoryError());
    }
  }
}