class Transaction {
  final String id;
  final String rewardName;  // Add this field
  final int amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.rewardName,  // Include it here as a required field
    required this.amount,
    required this.date,
  });
}