import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_event.dart';
import '../bloc/coin_bloc/coin_state.dart';
import '../bloc/reward_bloc/reward_bloc.dart';

class StoreScreen extends StatelessWidget {
  final List<Map<String, dynamic>> redeemableItems = [
    {"name": "Discount Coupon", "cost": 200},
    {"name": "Gift Card", "cost": 500},
    {"name": "Free Shipping", "cost": 300},
    {"name": "Bonus Coins", "cost": 100},
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: ListView.builder(
        itemCount: redeemableItems.length,
        itemBuilder: (context, index) {
          final item = redeemableItems[index];
          return ListTile(
            title: Text(item['name']),
            trailing: Text('${item['cost']} Coins'),
            onTap: () {
              final coinBloc = BlocProvider.of<CoinBloc>(context);
              // Check if the user has enough coins
              if (coinBloc.state is CoinLoaded &&
                  (coinBloc.state as CoinLoaded).balance >= item['cost']) {
                // Redeem the item
                coinBloc.add(UpdateCoinBalance(-item['cost'])); // Deduct coins
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Successfully redeemed ${item['name']}!'),
                ));
              } else {
                // Show insufficient coins message
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Insufficient Coins!'),
                ));
              }
            },
          );
        },
      ),
    );
  }
}

 void _handleRedemption(BuildContext context, int cost) {
  final currentBalance = context.read<CoinBloc>().state is CoinLoaded
      ? (context.read<CoinBloc>().state as CoinLoaded).balance
      : 0;

  if (currentBalance >= cost) {
    // Deduct the cost from the balance
    context.read<CoinBloc>().add(UpdateCoinBalance(-cost));
    // Notify the user of the successful redemption
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully redeemed for ${cost} coins!'),
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
