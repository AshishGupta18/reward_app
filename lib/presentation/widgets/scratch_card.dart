import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_event.dart';

class ScratchCardWidget extends StatefulWidget {
  final VoidCallback onScratch; // Callback to handle scratch event
  final DateTime nextScratchTime; // Next available scratch time

  const ScratchCardWidget({
    Key? key,
    required this.onScratch,
    required this.nextScratchTime,
  }) : super(key: key);

  @override
  _ScratchCardWidgetState createState() => _ScratchCardWidgetState();
}

class _ScratchCardWidgetState extends State<ScratchCardWidget> {
  int scratchAmount = 0;
  bool scratched = false;

  void scratchCard() {
    if (!scratched) {
      scratchAmount = (50 + (450 * (DateTime.now().microsecondsSinceEpoch % 10) / 10)).toInt(); // Random amount between 50 and 500
      scratched = true;

      // Call the parent widget's onScratch callback to update the time
      widget.onScratch();

      // Update the coin balance in the CoinBloc
      BlocProvider.of<CoinBloc>(context).add(UpdateCoinBalance(scratchAmount));

      setState(() {}); // Refresh the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the time left for the next scratch
    final timeLeft = widget.nextScratchTime.difference(DateTime.now()).inSeconds;

    return GestureDetector(
      onTap: scratchCard,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: scratched ? Colors.green[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              scratched ? 'You earned: $scratchAmount Coins!' : 'Scratch to reveal your coins!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            if (scratched) 
              Text(
                'Next scratch available in: ${timeLeft > 0 ? timeLeft : 0} seconds',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}