import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:syzygy/components/card.dart';
import 'package:syzygy/components/foundation-pile.dart';
import 'package:syzygy/components/tableau-pile.dart';
import 'package:syzygy/components/stock-pile.dart';
import 'package:syzygy/components/waste-pile.dart';

class KlondikeGame extends FlameGame {
  static const double cardWidth = 1000.0;
  static const double cardHeight = 1400.0;
  static const double cardGap = 175.0;
  static const double cardRadius = 100.0;
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);
  final int klondikeDraw = 1;

  static final cardRRect = RRect.fromRectAndRadius(
    const Rect.fromLTWH(0, 0, cardWidth, cardHeight),
    const Radius.circular(cardRadius),
  );
  @override
  Future<void> onLoad() async {
    Flame.device.setLandscape();
    Flame.device.fullScreen();
    await Flame.images.load('klondike-sprites.png');
    final stock = StockPile()
      ..size = cardSize
      ..position = Vector2(cardGap, cardGap);
    final waste = WastePile()
      ..size = cardSize
      ..position = Vector2(cardWidth + 2 * cardGap, cardGap);

    final foundations = List.generate(
      4,
      (i) => FoundationPile(i)
        ..size = cardSize
        ..position =
            Vector2((i + 3) * (cardWidth + cardGap) + cardGap, cardGap),
    );
    final piles = List.generate(
      7,
      (i) => TableauPile()
        ..size = cardSize
        ..position = Vector2(
          cardGap + i * (cardWidth + cardGap),
          cardHeight + 2 * cardGap,
        ),
    );

    world.add(stock);
    world.add(waste);
    world.addAll(foundations);
    world.addAll(piles);

    camera.viewfinder.visibleGameSize =
        Vector2(cardWidth * 7 + cardGap * 8, 4 * cardHeight + 3 * cardGap);
    camera.viewfinder.position = Vector2(cardWidth * 3.5 + cardGap * 4, 0);
    camera.viewfinder.anchor = Anchor.topCenter;

    // final random = Random();
    // for (var i = 0; i < 7; i++) {
    //   for (var j = 0; j < 4; j++) {
    //     final card = Card(random.nextInt(13) + 1, random.nextInt(4))
    //       ..position = Vector2(100 + i * 1150, 100 + j * 1500)
    //       ..addToParent(world);

    //     if (random.nextDouble() < 0.9) {
    //       card.flip();
    //     }
    //   }
    // }

    final cards = [
      for (var rank = 1; rank <= 13; rank++)
        for (var suite = 0; suite < 4; suite++) Card(rank, suite)
    ];

    cards.shuffle();

    world.addAll(cards);
    // cards.forEach(stock.acquiredCard);
    int cardToDeal = cards.length - 1;
    for (var i = 0; i < 7; i++) {
      for (var j = i; j < 7; j++) {
        piles[j].acquireCard(cards[cardToDeal--]);
      }
      piles[i].flipTopCard();
    }
    for (int n = 0; n <= cardToDeal; n++) {
      stock.acquiredCard(cards[n]);
    }
  }
}
