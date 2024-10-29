import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reward_app/domain/use_cases/get_scratch_reward.dart';
import 'package:reward_app/domain/use_cases/get_transaction_history.dart';
import 'package:reward_app/domain/use_cases/redeem_reward.dart';
import 'package:reward_app/main.dart';
import 'package:reward_app/presentation/bloc/bloc/transaction_bloc.dart';
import 'package:reward_app/presentation/bloc/coin_bloc/coin_bloc.dart';
import 'package:reward_app/presentation/bloc/reward_bloc/reward_bloc.dart';
import 'package:reward_app/data/repositories/reward_repository.dart'; // Adjust the import as necessary
import 'package:reward_app/data/repositories/transaction_repository.dart'; // Adjust the import as necessary
import 'package:reward_app/data/repositories/coin_repository.dart'; // Adjust the import as necessary

void main() {
  testWidgets('Home Screen shows correct initial coin balance', (WidgetTester tester) async {
    // Create instances of your Repositories
    final coinRepository = CoinRepository();
    final rewardRepository = RewardRepository();
    final transactionRepository = TransactionRepository();

    // Create instances of your Blocs with the required repositories
    final coinBloc = CoinBloc(); // Initialize with necessary parameters if needed
    final rewardBloc = RewardBloc(GetScratchReward(rewardRepository), RedeemReward(rewardRepository));
    final transactionBloc = TransactionBloc(GetTransactionHistory(transactionRepository));

    // Build the app with the required Blocs
    await tester.pumpWidget(
      MyApp(
        coinBloc: coinBloc,
        rewardBloc: rewardBloc,
        transactionBloc: transactionBloc,
      ),
    );

    // Verify initial UI state
    expect(find.text('1000'), findsOneWidget); // Assuming initial balance is 1000
    // Add more expectations for your UI elements
  });

  // Additional widget tests can be added here
}