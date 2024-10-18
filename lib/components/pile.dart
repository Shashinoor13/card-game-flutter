import 'package:FlameCard/components/card.dart';

enum MoveMethod { drag, tap }

abstract class Pile {
  bool canMoveCard(Card card, MoveMethod method);
  bool canAcceptCard(Card card);
  void removeCard(Card card, MoveMethod method);
  void acquireCard(Card card);
  void returnCard(Card card);
}
