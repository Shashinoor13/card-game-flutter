import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:FlameCard/components/card.dart';
import 'package:FlameCard/components/foundation-pile.dart';
import 'package:FlameCard/components/tableau-pile.dart';
import 'package:FlameCard/components/stock-pile.dart';
import 'package:FlameCard/components/waste-pile.dart';
import 'package:FlameCard/klondike_world.dart';

enum Action { newDeal, sameDeal, changeDraw, haveFun }

class KlondikeGame extends FlameGame {
  static const double cardGap = 175.0;
  static const double topGap = 1000.0;
  static const double cardWidth = 1000.0;
  static const double cardHeight = 1400.0;
  static const double cardRadius = 100.0;
  static const double cardSpaceWidth = cardWidth + cardGap;
  static const double cardSpaceHeight = cardHeight + cardGap;
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);
  static final cardRRect = RRect.fromRectAndRadius(
    const Rect.fromLTWH(0, 0, cardWidth, cardHeight),
    const Radius.circular(cardRadius),
  );

  /// Constant used to decide when a short drag is treated as a TapUp event.

  static const double dragTolerance = cardWidth / 5;

  // Constant used when creating Random seed.
  static const int maxInt = 0xFFFFFFFE; // = (2 to the power 32) - 1
  KlondikeGame() : super(world: KlondikeWorld());
  int klondikeDraw = 1;
  int seed = 1;
  Action action = Action.newDeal;
}
