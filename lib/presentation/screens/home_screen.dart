import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc/coin_state.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_event.dart';
import '/presentation/screens/store_screen.dart';
import '/presentation/screens/history_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger loading of initial coin balance
    context.read<CoinBloc>().loadBalance();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is CoinLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Coin Balance: ${state.balance}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StoreScreen()),
                      );
                    },
                    child: Text('Go to Store'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoryScreen()),
                      );
                    },
                    child: Text('Transaction History'),
                  ),
                ],
              ),
            );
          } else if (state is CoinLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Error loading coin balance'));
          }
        },
      ),
    );
  }
}