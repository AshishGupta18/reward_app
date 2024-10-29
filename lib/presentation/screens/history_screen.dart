import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/transaction_bloc.dart';
import '../bloc/bloc/transaction_state.dart';


class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionHistoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TransactionHistoryLoaded) {
            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.transactions[index].rewardName),
                  subtitle: Text('Redeemed: ${state.transactions[index].date}'),
                );
              },
            );
          } else {
            return Center(child: Text('Error loading transaction history'));
          }
        },
      ),
    );
  }
}