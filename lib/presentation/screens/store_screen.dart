import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_event.dart';
import '../bloc/coin_bloc/coin_state.dart';

class StoreScreen extends StatelessWidget {
  final List<Map<String, dynamic>> redeemableItems = [
    {"name": "Discount Card", "cost": 200},
    {"name": "Gift Card", "cost": 500},
    {"name": "Free Shipping", "cost": 300},
    {"name": "Bonus Coins", "cost": 100},
    {"name": "Kinder Joy", "cost": 50},
    {"name": "Emotorad bike", "cost": 800},
    {"name": "Shirt", "cost": 400},
    {"name": "Food Coupon", "cost": 250},
  ];

  void _handleRedemption(BuildContext context, int cost, String itemName) {
    final currentBalance = context.read<CoinBloc>().state is CoinLoaded
        ? (context.read<CoinBloc>().state as CoinLoaded).balance
        : 0;

    if (currentBalance >= cost) {
      // Deduct the cost from the balance
      context.read<CoinBloc>().add(UpdateCoinBalance(-cost));
      // Notify the user of the successful redemption
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully redeemed for $itemName!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Notify the user of insufficient coins
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insufficient Coins!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75, // Adjusts the aspect ratio of the cards
          ),
          itemCount: redeemableItems.length,
          itemBuilder: (context, index) {
            final item = redeemableItems[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => _handleRedemption(context, item['cost'], item['name']),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${item['cost']} Coins',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.card_giftcard,
                        size: 40,
                        color: Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}