// lib/presentation/widgets/scratch_card_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_event.dart';

class ScratchCardWidget extends StatefulWidget {
  @override
  _ScratchCardWidgetState createState() => _ScratchCardWidgetState();
}

class _ScratchCardWidgetState extends State<ScratchCardWidget> {
  int scratchAmount = 0;
  bool scratched = false;
  DateTime nextScratchTime = DateTime.now();

  void scratchCard() {
    if (!scratched) {
      scratchAmount = (50 + (450 * (DateTime.now().microsecondsSinceEpoch % 10) / 10)).toInt(); // Random amount between 50 and 500
      scratched = true;
      nextScratchTime = DateTime.now().add(Duration(hours: 1));

      // Update the coin balance in the CoinBloc
      BlocProvider.of<CoinBloc>(context).add(UpdateCoinBalance(scratchAmount));
      
      setState(() {}); // Refresh the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeLeft = nextScratchTime.difference(DateTime.now()).inSeconds;

    return GestureDetector(
      onTap: scratchCard,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              scratched ? 'You earned: $scratchAmount Coins!' : 'Scratch to reveal your coins!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            if (scratched) 
              Text('Next scratch available in: ${timeLeft > 0 ? timeLeft : 0} seconds'),
          ],
        ),
      ),
    );
  }
}