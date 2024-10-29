// lib/domain/use_cases/redeem_reward.dart

import '/domain/repositories/reward_repository_interface.dart';

class RedeemReward {
  final RewardRepositoryInterface repository;

  RedeemReward(this.repository);

  bool call(String itemId) {
    return repository.redeemReward(itemId);
  }
}