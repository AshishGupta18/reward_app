import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/coin_bloc/coin_state.dart';
import '../bloc/coin_bloc/coin_bloc.dart';
import '../bloc/coin_bloc/coin_event.dart';
import '/presentation/screens/store_screen.dart';
import '/presentation/screens/history_screen.dart';
import '../widgets/scratch_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int coinBalance = 1000; // Default coin balance
  DateTime nextScratchTime = DateTime.now(); // Manage next scratch time
  late AnimationController _controller; // Animation controller
  late Animation<double> _animation; // Animation for the scratch card

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _updateBalance(int amount) {
    setState(() {
      coinBalance += amount; // Update the balance when the user scratches the card
    });
  }

  void _scratchCard() {
    // Update nextScratchTime to one hour later after scratching
    setState(() {
      nextScratchTime = DateTime.now().add(Duration(hours: 1));
      _controller.forward(); // Start the animation when scratching
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is CoinLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0), // Add padding
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Coin Balance: ${state.balance}',
                      style: Theme.of(context).textTheme.headline4, // Use theme
                    ),
                    SizedBox(height: 20),
                    // Animated scratch card
                    FadeTransition(
                      opacity: _animation,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity, // Make the scratch card wider
                        height: 150, // Make the scratch card taller
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: ScratchCardWidget(
                          onScratch: _scratchCard, // Pass the scratch function
                          nextScratchTime: nextScratchTime, // Pass the next scratch time
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Go to Store button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StoreScreen()),
                          );
                        },
                        child: Text('Go to Store', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          primary: Colors.teal, // Button color
                          elevation: 5,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Transaction History button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HistoryScreen()),
                          );
                        },
                        child: Text('Transaction History', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          primary: Colors.teal, // Button color
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CoinLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Error loading coin balance'));
          }
        },
      ),
    );
  }
}