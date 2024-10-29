// lib/presentation/bloc/reward_bloc/reward_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/use_cases/redeem_reward.dart';
import '/domain/use_cases/get_scratch_reward.dart';
import 'reward_event.dart';
import 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final GetScratchReward getScratchReward;
  final RedeemReward redeemReward;

  RewardBloc(this.getScratchReward, this.redeemReward) : super(RewardInitial());

  @override
  Stream<RewardState> mapEventToState(RewardEvent event) async* {
    if (event is FetchRewards) {
      // Logic to fetch rewards
    } else if (event is RedeemRewardEvent) {
      final success = redeemReward(event.itemId);
      yield RewardRedeemed(success ? "Redeemed Successfully" : "Redemption Failed");
    }
  }
}