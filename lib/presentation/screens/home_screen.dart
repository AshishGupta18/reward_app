import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc/coin_state.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_event.dart';
import '/presentation/screens/store_screen.dart';
import '/presentation/screens/history_screen.dart';
import '../widgets/scratch_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int coinBalance = 1000; // Default coin balance

  void _updateBalance(int amount) {
    setState(() {
      coinBalance += amount; // Update the balance when the user scratches the card
    });
  }

   @override
  Widget build(BuildContext context) {
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
                  ScratchCardWidget(), // Add the scratch card widget
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