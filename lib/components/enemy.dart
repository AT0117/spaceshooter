import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/components/particle_generator.dart';
import 'package:spaceshooter/components/planet.dart';
import 'package:spaceshooter/constants.dart';

class Enemy extends CircleComponent with HasGameReference, CollisionCallbacks {
  Enemy({required Vector2 position})
    : super(
        position: position,
        radius: 10,
        anchor: Anchor.center,
        paint: Paint()..color = GameConfig.enemyColor,
      );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 target = game.size / 2;
    Vector2 direction = (target - position).normalized();
    position += direction * GameConfig.enemySpeed * dt;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      game.add(ParticleGenerator.createExplosion(position));

      removeFromParent();
      other.removeFromParent();
    }

    if (other is Planet) {
      game.overlays.add('GAME OVER');
      removeFromParent();
    }
  }
}
