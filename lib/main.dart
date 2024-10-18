import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:FlameCard/klondike_game.dart';

void main() {
  final game = KlondikeGame();
  runApp(GameWidget(
    game: game,
    backgroundBuilder: (context) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('/images/carpet-background.jpg'),
            fit: BoxFit.cover),
      ),
    ),
  ));
  ;
}
