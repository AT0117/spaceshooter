import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spaceshooter/constants.dart';

class Bullet extends RectangleComponent
    with HasGameReference, CollisionCallbacks {
  final double angleAtFire;

  Bullet({required Vector2 position, required this.angleAtFire})
    : super(
        position: position,
        size: Vector2(4, 10),
        anchor: Anchor.center,
        angle: angleAtFire,
        paint: Paint()..color = GameConfig.bulletColor,
      );

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(
      Vector2(0, -1)
        ..rotate(angleAtFire)
        ..scale(GameConfig.bulletSpeed * dt),
    );
    if (position.x < 0 || position.y < 0) {
      removeFromParent();
    }
  }
}
