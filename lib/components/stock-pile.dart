import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:FlameCard/components/card.dart';
import 'package:FlameCard/components/pile.dart';
import 'package:FlameCard/components/waste-pile.dart';
import 'package:FlameCard/klondike_game.dart';

class StockPile extends PositionComponent
    with TapCallbacks, HasGameReference<KlondikeGame>
    implements Pile {
  StockPile({super.position}) : super(size: KlondikeGame.cardSize);

  final List<Card> _cards = [];

  void acquiredCard(Card card) {
    assert(!card.isFaceUp);
    card.position = position;
    card.priority = _cards.length;
    card.pile = this;
    _cards.add(card);
  }

  @override
  void onTapUp(TapUpEvent event) {
    final wastePile = parent!.firstChild<WastePile>()!;
    if (_cards.isEmpty) {
      wastePile.removeAllCards().reversed.forEach((card) {
        card.flip();
        acquiredCard(card);
      });
    } else {
      for (var i = 0; i < game.klondikeDraw; i++) {
        if (_cards.isNotEmpty) {
          final card = _cards.removeLast();
          card.doMoveAndFlip(wastePile.position, whenDone: () {
            wastePile.acquiredCard(card);
          });
        }
      }
    }
  }

  void handleTapUp(Card card) {
    final wastePile = parent!.firstChild<WastePile>()!;

    if (_cards.isEmpty) {
      assert(card.isBaseCard, 'Stock Pile is empty, but no Base Card present');

      card.position = position; // Force Base Card (back) into correct position.

      wastePile.removeAllCards().reversed.forEach((card) {
        card.flip();

        acquireCard(card);
      });
    } else {
      for (var i = 0; i < game.klondikeDraw; i++) {
        if (_cards.isNotEmpty) {
          final card = _cards.removeLast();

          card.doMoveAndFlip(
            wastePile.position,
            whenDone: () {
              wastePile.acquireCard(card);
            },
          );
        }
      }
    }
  }

  @override
  bool canMoveCard(Card card, MoveMethod method) => false;

  @override
  bool canAcceptCard(Card card) => false;

  @override
  void removeCard(Card card, MoveMethod method) {
    throw StateError('Cannot remove cards from stock pile');
  }

  @override
  void acquireCard(Card card) {
    acquiredCard(card);
  }

  @override
  void returnCard(Card card) =>
      throw StateError('cannot remove cards from here');
}
