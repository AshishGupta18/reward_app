// lib/presentation/bloc/reward_bloc/reward_state.dart

import '/domain/entities/reward.dart';

abstract class RewardState {}

class RewardInitial extends RewardState {}

class RewardLoaded extends RewardState {
  final List<Reward> rewards;

  RewardLoaded(this.rewards);
}

class RewardRedeemed extends RewardState {
  final String message;

  RewardRedeemed(this.message);
}

class RewardError extends RewardState {
  final String message;

  RewardError(this.message);
}
