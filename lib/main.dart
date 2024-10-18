import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:syzygy/klondike_game.dart';

void main() {
  final game = KlondikeGame();
  runApp(GameWidget(game: game));
  ;
}
