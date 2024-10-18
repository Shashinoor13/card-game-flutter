import 'dart:ui';

import 'package:flame/components.dart';
import 'package:syzygy/components/card.dart';
import 'package:syzygy/components/pile.dart';
import 'package:syzygy/components/suite.dart';
import 'package:syzygy/klondike_game.dart';

class FoundationPile extends PositionComponent implements Pile {
  FoundationPile(int intSuite, {super.position})
      : suite = Suite.fromInt(intSuite),
        super(size: KlondikeGame.cardSize);
  final Suite suite;
  final List<Card> _cards = [];

  void acquiredCard(Card card) {
    assert(card.isFaceUp);
    card.position = position;
    card.priority = _cards.length;
    card.pile = this;

    _cards.add(card);
  }

  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = const Color(0x50ffffff);
  late final _suitPaint = Paint()
    ..color = suite.isRed ? const Color(0x3a000000) : const Color(0x64000000)
    ..blendMode = BlendMode.luminosity;
  @override
  void render(Canvas canvas) {
    canvas.drawRRect(KlondikeGame.cardRRect, _borderPaint);
    suite.sprite.render(
      canvas,
      position: size / 2,
      anchor: Anchor.center,
      size: Vector2.all(KlondikeGame.cardWidth * 0.6),
      overridePaint: _suitPaint,
    );
  }

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && card == _cards.last;

  @override
  bool canAcceptCard(Card card) {
    final topCardRank = _cards.isEmpty ? 0 : _cards.last.rank.value;
    return card.suite == suite &&
        card.rank.value == topCardRank + 1 &&
        card.attachedCards.isEmpty;
  }

  @override
  void removeCard(Card card) {
    assert(canMoveCard(card));
    _cards.removeLast();
  }

  @override
  void acquireCard(Card card) {
    acquiredCard(card);
  }

  @override
  void returnCard(Card card) {
    card.position = position;
    card.priority = _cards.indexOf(card);
  }
}
