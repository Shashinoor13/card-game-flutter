import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:FlameCard/klondike_game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _showGame = false;

  void _startGame() {
    setState(() {
      _showGame = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showGame) {
      final game = KlondikeGame();
      return GameWidget(
        game: game,
        backgroundBuilder: (context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/carpet-background.jpg'),
                fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green.shade800, Colors.green.shade600],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Klondike Solitaire',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: _startGame,
                    child: Text('Play Game', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green.shade800,
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () => _showHowToPlay(context),
                    child: Text('How to Play', style: TextStyle(fontSize: 18)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

void _showHowToPlay(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'How to Play Klondike Solitaire',
        style: TextStyle(
          color: Colors.green.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Objective:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Build four foundation piles from Ace to King in each suit.'),
            SizedBox(height: 10),
            Text(
              'Setup:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
                '• Deal 28 cards into 7 tableau piles, with the top card face-up.'),
            Text('• Place remaining cards face-down as the stock pile.'),
            SizedBox(height: 10),
            Text(
              'Rules:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
                '1. Move cards between tableau piles in descending order and alternating colors.'),
            Text('2. Flip over face-down tableau cards when exposed.'),
            Text('3. Move Aces to foundation piles and build up in suit.'),
            Text('4. Draw cards from the stock pile to the waste pile.'),
            Text('5. Move Kings to empty tableau spaces.'),
            SizedBox(height: 10),
            Text(
              'Winning:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Complete all four foundation piles from Ace to King.'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close', style: TextStyle(color: Colors.green.shade800)),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.green.shade50,
    ),
  );
}
