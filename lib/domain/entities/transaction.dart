class Transaction {

  final String type;  // Add this field
  final int amount;
  final DateTime date;

  Transaction({

    required this.type,  // Include it here as a required field
    required this.amount,
    required this.date,
  });
}