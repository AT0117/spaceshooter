import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:spaceshooter/constants.dart';

class Planet extends SpriteComponent with HasGameReference, CollisionCallbacks {
  Planet()
    : super(
        size: Vector2.all(GameConfig.planetRadius * 2),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('earth.png');
    add(CircleHitbox());
    add(
      RotateEffect.by(
        math.pi * 2,
        EffectController(duration: 20, infinite: true),
      ),
    );
  }
}
