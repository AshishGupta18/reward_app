// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reward_app/domain/use_cases/get_scratch_reward.dart';
import '/presentation/bloc/coin_bloc/coin_bloc.dart';
import '/presentation/bloc/reward_bloc/reward_bloc.dart';
import '/domain/use_cases/get_coin_balance.dart';
import '/domain/use_cases/redeem_reward.dart';
import '/domain/use_cases/get_transaction_history.dart';
import '/data/repositories/coin_repository.dart';
import '/data/repositories/reward_repository.dart';
import '/data/repositories/transaction_repository.dart';
import '/config/app_theme.dart';
import '/config/app_routes.dart';
import '/presentation/screens/home_screen.dart';
import 'presentation/bloc/bloc/transaction_bloc.dart';
import 'presentation/bloc/coin_bloc/coin_event.dart';

void main() {
  final CoinRepository coinRepository = CoinRepository();
  final RewardRepository rewardRepository = RewardRepository();
  final TransactionRepository transactionRepository = TransactionRepository();

  runApp(MyApp(
   coinBloc: CoinBloc()..add(LoadCoinBalance()),
    rewardBloc: RewardBloc(GetScratchReward(rewardRepository), RedeemReward(rewardRepository)),
    transactionBloc: TransactionBloc(GetTransactionHistory(transactionRepository)),
  ));
}

class MyApp extends StatelessWidget {
  final CoinBloc coinBloc;
  final RewardBloc rewardBloc;
  final TransactionBloc transactionBloc;

  MyApp({
    required this.coinBloc,
    required this.rewardBloc,
    required this.transactionBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoinBloc>(create: (_) => coinBloc),
        BlocProvider<RewardBloc>(create: (_) => rewardBloc),
        BlocProvider<TransactionBloc>(create: (_) => transactionBloc),
      ],
      child: MaterialApp(
        title: 'Reward Coins Application',
        theme: AppTheme.theme,
        routes: appRoutes,
      ),
    );
  }
}