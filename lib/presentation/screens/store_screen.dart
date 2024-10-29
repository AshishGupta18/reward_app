import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc/reward_state.dart';
import '/presentation/bloc/reward_bloc/reward_bloc.dart';
import '/presentation/widgets/reward_item.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: BlocBuilder<RewardBloc, RewardState>(
        builder: (context, state) {
          if (state is RewardLoaded) {
            return ListView.builder(
              itemCount: state.rewards.length,
              itemBuilder: (context, index) {
                return RewardItem(reward: state.rewards[index]);
              },
            );
          } else if (state is RewardLoaded) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Error loading rewards'));
          }
        },
      ),
    );
  }
}