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
        title: Text('Transaction History', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              dropdownColor: Colors.white,
              underline: SizedBox(),
              icon: Icon(Icons.filter_list, color: Colors.black),
              items: <String>['All', 'Scratch Card Reward', 'Redeemed Item']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                  _filterTransactions();
                });
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is CoinLoaded) {
            return filteredTransactions.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      Transaction transaction = filteredTransactions[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            transaction.type,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Date: ${transaction.date.toLocal().toString().split(' ')[0]}'),
                          trailing: Text(
                            '${transaction.amount} Coins',
                            style: TextStyle(
                              color: transaction.type == 'Redeemed Item' ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: Text('No transactions found', style: TextStyle(fontSize: 18)));
          } else if (state is CoinLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Error loading transactions', style: TextStyle(fontSize: 18)));
          }
        },
      ),
    );
  }
}