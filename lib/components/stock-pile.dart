import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:syzygy/components/card.dart';
import 'package:syzygy/components/pile.dart';
import 'package:syzygy/components/waste-pile.dart';
import 'package:syzygy/klondike_game.dart';

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

  @override
  bool canMoveCard(Card card) => false;

  @override
  bool canAcceptCard(Card card) => false;

  @override
  void removeCard(Card card) {
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
