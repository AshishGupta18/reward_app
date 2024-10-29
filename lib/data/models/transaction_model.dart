class TransactionModel {
  final String transactionId;
  final String rewardName; // E.g., 'Scratch Card Reward' or 'Redeemed Item'
  final int amount;
   final DateTime date;

  TransactionModel({
    required this.transactionId,
    required this.rewardName,
    required this.amount,
      required this.date,
  });
}