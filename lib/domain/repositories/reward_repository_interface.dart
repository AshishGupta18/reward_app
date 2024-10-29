// lib/domain/repositories/reward_repository_interface.dart

import '/domain/entities/reward.dart';

abstract class RewardRepositoryInterface {
  List<Reward> fetchRewards();
  bool redeemReward(String itemId);
}