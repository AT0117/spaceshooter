import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class SpaceBackground extends SpriteComponent with HasGameReference {
  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('background.jpg');
    size = game.size;

    add(
      OpacityEffect.to(
        0.8,
        EffectController(duration: 3, reverseDuration: 3, infinite: true),
      ),
    );
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    size = newSize;
  }
}
