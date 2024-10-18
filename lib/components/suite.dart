import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:syzygy/helpers/sprite-helper.dart';

@immutable
class Suite {
  final int value;
  final String label;
  final Sprite sprite;

  Suite._(this.value, this.label, double x, double y, double w, double h)
      : sprite = klondikeSprite(x, y, w, h);

  factory Suite.fromInt(int index) {
    assert(index >= 0 && index <= 3);
    return _singletons[index];
  }

  static final List<Suite> _singletons = [
    Suite._(0, '♥', 1176, 17, 172, 183),
    Suite._(1, '♦', 973, 14, 177, 182),
    Suite._(2, '♣', 974, 226, 184, 172),
    Suite._(3, '♠', 1178, 220, 176, 182),
  ];

  bool get isRed => value <= 1;
  bool get isBlack => value >= 2;
}
