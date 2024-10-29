import 'package:flutter/material.dart';
import '/domain/entities/reward.dart';

class RewardItem extends StatelessWidget {
  final Reward reward;

  RewardItem({required this.reward});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reward.name),
      subtitle: Text('Cost: ${reward.cost} Coins'),
      trailing: ElevatedButton(
        onPressed: () {
          // Trigger redeem reward event here
        },
        child: Text('Redeem'),
      ),
    );
  }
}