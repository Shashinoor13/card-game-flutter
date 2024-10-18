import 'dart:ui';

import 'package:flame/components.dart';
import 'package:syzygy/components/card.dart';
import 'package:syzygy/components/pile.dart';
import 'package:syzygy/klondike_game.dart';

class WastePile extends PositionComponent
    with HasGameReference<KlondikeGame>
    implements Pile {
  WastePile({super.position}) : super(size: KlondikeGame.cardSize);

  final List<Card> _cards = [];
  final Vector2 _fanOffset = Vector2(KlondikeGame.cardWidth * 0.2, 0);
  void acquiredCard(Card card) {
    assert(card.isFaceUp);
    card.position = position;
    card.priority = _cards.length;
    card.pile = this;

    _cards.add(card);
    _fanOutTopCards();
  }

  void _fanOutTopCards() {
    if (game.klondikeDraw == 1) return;

    final n = _cards.length;

    for (var i = 0; i < n; i++) {
      _cards[i].position = position;
    }

    if (n == 2) {
      _cards[1].position.add(_fanOffset);
    } else if (n >= 3) {
      _cards[n - 2].position.add(_fanOffset);
      _cards[n - 1].position.addScaled(_fanOffset, 2);
    }
  }

  @override
  void render(Canvas canvas) {
    final _borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = const Color(0xFF3F5B5D);
    final _circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 100
      ..color = const Color(0x883F5B5D);
    canvas.drawRRect(KlondikeGame.cardRRect, _borderPaint);
    canvas.drawCircle(
      Offset(width / 2, height / 2),
      KlondikeGame.cardWidth * 0.3,
      _circlePaint,
    );
  }

  List<Card> removeAllCards() {
    final cards = List<Card>.from(_cards);
    _cards.clear();
    return cards;
  }

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && _cards.last == card;

  @override
  bool canAcceptCard(Card card) => false;

  @override
  void removeCard(Card card) {
    assert(canMoveCard(card));
    _cards.removeLast();
    _fanOutTopCards();
  }

  @override
  void acquireCard(Card card) {
    acquiredCard(card);
  }

  @override
  void returnCard(Card card) {
    card.priority = _cards.indexOf(card);
    _fanOutTopCards();
  }
}
