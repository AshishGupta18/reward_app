// lib/presentation/bloc/reward_bloc/reward_event.dart

abstract class RewardEvent {}

class FetchRewards extends RewardEvent {}
class RedeemRewardEvent extends RewardEvent {
  final String itemId;

  RedeemRewardEvent(this.itemId);
}