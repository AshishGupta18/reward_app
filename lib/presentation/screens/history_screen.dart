// lib/presentation/screens/history_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/transaction.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_state.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Transaction> filteredTransactions = [];
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredTransactions = _getAllTransactions();
  }

  List<Transaction> _getAllTransactions() {
    final coinBloc = BlocProvider.of<CoinBloc>(context);
    if (coinBloc.state is CoinLoaded) {
      return coinBloc.transactionHistory;
    }
    return [];
  }

  void _filterTransactions() {
    final coinBloc = BlocProvider.of<CoinBloc>(context);
    List<Transaction> allTransactions = coinBloc.transactionHistory;

    if (selectedFilter == 'All') {
      filteredTransactions = allTransactions;
    } else {
      filteredTransactions = allTransactions
          .where((transaction) => transaction.type == selectedFilter)
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        actions: [
          DropdownButton<String>(
            value: selectedFilter,
            items: <String>['All', 'Scratch Card Reward', 'Redeemed Item']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedFilter = value!;
                _filterTransactions();
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is CoinLoaded) {
            return ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                Transaction transaction = filteredTransactions[index];
                return ListTile(
                  title: Text(transaction.type),
                  subtitle: Text('Date: ${transaction.date.toLocal()}'),
                  trailing: Text('${transaction.amount} Coins'),
                );
              },
            );
          } else if (state is CoinLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('No transactions found'));
          }
        },
      ),
    );
  }
}